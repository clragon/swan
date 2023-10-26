import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:nyxx/nyxx.dart';
import 'package:petitparser/petitparser.dart';
import 'package:swan/plugins/base/plugin.dart';
import 'package:swan/plugins/dartdoc/dartdoc_entry.dart';
import 'package:swan/plugins/dartdoc/search_grammar.dart';
import 'package:swan/plugins/env/plugin.dart';

/// Very optimised, black magic.
/// Adapted from https://en.wikipedia.org/wiki/Levenshtein_distance#Iterative_with_two_matrix_rows
int lehvenstein(String s, String t) {
  final m = s.length;
  final n = t.length;

  var v0 = Uint8ClampedList(n + 1);
  var v1 = Uint8ClampedList(n + 1);

  for (int i = 0; i <= n; i++) {
    v0[i] = i;
  }

  for (int i = 0; i <= m - 1; i++) {
    var previousV1 = v1[0] = i + 1;
    var previousV0 = v0[0];

    for (int j = 0; j <= n - 1; j++) {
      var substitutionCost = previousV0 + 1;
      if (s[i] == t[j]) {
        substitutionCost--;
      }

      previousV0 = v0[j + 1];

      final deletionCost = previousV0;
      final insertionCost = previousV1;

      var minInsertionDeletion =
          deletionCost < insertionCost ? deletionCost : insertionCost;
      minInsertionDeletion++;

      final overallMin = substitutionCost < minInsertionDeletion
          ? substitutionCost
          : minInsertionDeletion;

      previousV1 = overallMin;
      v1[j + 1] = previousV1;
    }

    (v0, v1) = (v1, v0);
  }

  return v0[n];
}

class DartdocSearch extends BotPlugin {
  DartdocSearch() {
    // Fetching the flutter cache index takes quite a long time (as it is a very
    // large package) and it is probably the most commonly used package, so we
    // eagerly update the cache before it expires.
    //
    // Other packages are fetched and updated as needed.
    flutterCacheTimer = Timer.periodic(
      expireDuration * 0.9,
      (_) => getEntries('flutter'),
    );

    // Kick off an initial load immediately
    getEntries('flutter');
  }

  static const expireDuration = Duration(hours: 1);

  @override
  String get name => 'DartdocSearch';

  final documentationCache = <String, (DateTime, List<DartdocEntry>)>{};

  late final Timer flutterCacheTimer;

  @override
  bool isEnabled(NyxxGateway client) => !(client.env.disableDartdocs ?? false);

  @override
  String buildHelpText(NyxxGateway client) => r'''
Search Flutter & pub.dev package API documentation
- `![Name]` or `![package/Name]`: Return the documentation for `Name` in Flutter's or `package`'s API documentation
- `?[Name]` or `?[package/Name]`: Search for `Name` in Flutter's or `package`'s API documentation
- `$[name]`: Return the pub.dev page for the package `name`
- `&[name]`: Search pub.dev for `name`
      ''';

  Future<(String, List<DartdocEntry>)> getEntries(String package) async {
    final cached = documentationCache[package];
    final now = DateTime.timestamp();
    final cacheExpiry = now.add(-expireDuration);

    final urlBase = package == 'flutter' || package == 'dart'
        ? 'https://api.flutter.dev/flutter/'
        : 'https://pub.dev/documentation/$package/latest/';

    final url = '${urlBase}index.json';

    if (cached != null && cached.$1.isAfter(cacheExpiry)) {
      return (urlBase, cached.$2);
    }

    logger.info('Updating documentation cache for $package');

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) return (urlBase, <DartdocEntry>[]);

    final content = jsonDecode(utf8.decode(response.bodyBytes)) as List;

    final entries = [
      for (final map in content.cast<Map<String, dynamic>>())
        if (!map.containsKey('__PACKAGE_ORDER__')) DartdocEntry.fromJson(map),
    ];

    documentationCache[package] = (now, entries);
    return (urlBase, entries);
  }

  final searchCache = <String, (DateTime, List<String>)>{};

  Future<List<String>> searchPackages(String query) async {
    // Most common case.
    if (query == 'flutter') return ['flutter'];

    // A cache isn't really needed here (since the most common case by far is
    // hard coded above) but it avoids triggering multiple requests when a
    // package's documentation is referenced multiple times in one message.
    final cached = searchCache[query];
    final now = DateTime.timestamp();
    final cacheExpiry = now.add(-expireDuration);

    if (cached != null && cached.$1.isAfter(cacheExpiry)) {
      return cached.$2;
    }

    final response = await http.get(
      Uri.https('pub.dev', '/api/search', {'q': query}),
    );
    final content = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

    final results = (content['packages'] as List)
        .map((e) => e['package'] as String)
        .toList();

    searchCache[query] = (now, results);
    return results;
  }

  @override
  void afterConnect(NyxxGateway client) {
    if (!isEnabled(client)) return;

    final parser = SearchGrammar().build<List<Search>>();

    Future<void> handle(Search search, MessageCreateEvent event) async {
      switch (search.kind) {
        case SearchKind.elementLookup:
        case SearchKind.elementSearch:
          final matchingPackages = await searchPackages(search.package!);

          if (matchingPackages.isEmpty) {
            await event.message.channel.sendMessage(MessageBuilder(
              replyId: event.message.id,
              allowedMentions: AllowedMentions(repliedUser: false),
              embeds: [
                EmbedBuilder(
                  color: const DiscordColor.fromRgb(255, 0, 0),
                  title: 'Package Not Found',
                  description: search.package!,
                ),
              ],
            ));
            return;
          }

          final package = matchingPackages.first;

          final (urlBase, entries) = await getEntries(package);

          final useNamePattern = RegExp(r'^([A-Za-z$_A-Za-z0-9$_]*?)$');
          final query = search.name;
          final byName = useNamePattern.hasMatch(search.name);

          // lehvenstein can block, especially if we are searching the Flutter
          // docs (80k+ calls). We need to move the isolate creation to a
          // different function to avoid capturing `this` in the closure
          // context.
          Future<List<DartdocEntry>> process(
            String query,
            List<DartdocEntry> entries, {
            required bool byName,
          }) {
            return Isolate.run(() {
              final results = List.of(entries.map(
                (e) => (
                  lehvenstein(
                    query,
                    byName ? e.name : e.qualifiedName,
                  ),
                  e,
                ),
              ));

              results.sort((a, b) => a.$1.compareTo(b.$1));
              return List.of(results.map((e) => e.$2));
            });
          }

          final results = await process(
            query,
            entries,
            byName: byName,
          );

          if (results.isEmpty) {
            await event.message.channel.sendMessage(MessageBuilder(
              replyId: event.message.id,
              allowedMentions: AllowedMentions(repliedUser: false),
              embeds: [
                EmbedBuilder(
                  color: const DiscordColor.fromRgb(255, 0, 0),
                  title: 'Not Found',
                  description: search.name,
                ),
              ],
            ));
            return;
          }

          if (search.kind == SearchKind.elementLookup) {
            final topEntry = results.first;

            await event.message.channel.sendMessage(MessageBuilder(
              replyId: event.message.id,
              allowedMentions: AllowedMentions(repliedUser: false),
              content: '$urlBase${topEntry.href}',
            ));
          } else {
            await event.message.channel.sendMessage(MessageBuilder(
              replyId: event.message.id,
              allowedMentions: AllowedMentions(repliedUser: false),
              embeds: [
                EmbedBuilder(
                  title: 'Pub Search Results - ${search.name}',
                  fields: [
                    for (final result in results)
                      EmbedFieldBuilder(
                        name:
                            '${result.type} ${result.name} - ${result.enclosedBy?.type ?? package}',
                        value: '$urlBase${result.href}',
                        isInline: false,
                      ),
                  ],
                ),
              ],
            ));
          }
        case SearchKind.packageLookup:
        case SearchKind.packageSearch:
          final results = await searchPackages(search.name);

          if (results.isEmpty) {
            await event.message.channel.sendMessage(MessageBuilder(
              replyId: event.message.id,
              allowedMentions: AllowedMentions(repliedUser: false),
              embeds: [
                EmbedBuilder(
                  color: const DiscordColor.fromRgb(255, 0, 0),
                  title: 'Not Found',
                  description: search.name,
                ),
              ],
            ));
            return;
          }

          if (search.kind == SearchKind.packageLookup) {
            await event.message.channel.sendMessage(MessageBuilder(
              replyId: event.message.id,
              allowedMentions: AllowedMentions(repliedUser: false),
              content: 'https://pub.dev/packages/${results.first}',
            ));
          } else {
            await event.message.channel.sendMessage(MessageBuilder(
              replyId: event.message.id,
              allowedMentions: AllowedMentions(repliedUser: false),
              embeds: [
                EmbedBuilder(
                  title: 'Pub Search Results - ${search.name}',
                  fields: [
                    for (final result in results.take(10))
                      EmbedFieldBuilder(
                        name: result,
                        value: 'https://pub.dev/packages/$result',
                        isInline: false,
                      ),
                  ],
                ),
              ],
            ));
          }
      }
    }

    client.onMessageCreate.listen((event) async {
      if (parser.parse(event.message.content) case Success(:final value)) {
        for (final search in value) {
          if (event.message.author case User(isBot: false)) {
            await handle(search, event);
          }
        }
      }
    });
  }

  @override
  void afterClose() {
    flutterCacheTimer.cancel();
  }
}

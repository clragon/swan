import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:nyxx/nyxx.dart';
import 'package:petitparser/petitparser.dart';
import 'package:swan/plugins/base/messages.dart';
import 'package:swan/plugins/base/plugin.dart';
import 'package:swan/plugins/dartdoc/dartdoc_entry.dart';
import 'package:swan/plugins/dartdoc/search_grammar.dart';

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
      (_) => getEntries('flutter', bypassCache: true),
    );

    // Kick off an initial load immediately
    getEntries('flutter', bypassCache: true);
  }

  static const expireDuration = Duration(hours: 1);

  @override
  String get name => 'DartdocSearch';

  final documentationCache = <String, (DateTime, List<DartdocEntry>)>{};

  late final Timer flutterCacheTimer;

  @override
  String buildHelpText(NyxxGateway client) =>
      'Search Flutter & pub.dev package API documentation\n'
      "- `![Name]` or `![package/Name]`: Return the documentation for `Name` in Flutter's or `package`'s API documentation\n"
      "- `?[Name]` or `?[package/Name]`: Search for `Name` in Flutter's or `package`'s API documentation\n"
      '- `\$[name]`: Return the pub.dev page for the package `name`\n'
      '- `&[name]`: Search pub.dev for `name`\n';

  String removeCodeBlocks(String text) {
    const notEscaped = r'(?<!\\)';
    return text.replaceAll(
      RegExp(
        r'('
        '$notEscaped'
        r'```'
        r'[\s\S]+?'
        '$notEscaped'
        '```'
        r')' // removes not escaped triple backtick code blocks
        r'|'
        r'('
        '$notEscaped'
        r'(?<!`)'
        r'`'
        r'[^`]+'
        '$notEscaped'
        r'`'
        '(?!`)'
        r')', // removes not escaped single backtick code blocks
      ),
      '',
    );
  }

  Future<(String, List<DartdocEntry>)> getEntries(
    String package, {
    bool bypassCache = false,
  }) async {
    final cached = documentationCache[package];
    final now = DateTime.timestamp();
    final cacheExpiry = now.add(-expireDuration);

    final urlBase = package == 'flutter' || package == 'dart'
        ? 'https://api.flutter.dev/flutter/'
        : 'https://pub.dev/documentation/$package/latest/';

    final url = '${urlBase}index.json';

    if (!bypassCache && cached != null && cached.$1.isAfter(cacheExpiry)) {
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
            break;
          }

          final package = matchingPackages.first;

          final (urlBase, entries) = await getEntries(package);

          final query = search.name;
          final periodCount = '.'.allMatches(query).length;

          // lehvenstein can block, especially if we are searching the Flutter
          // docs (80k+ calls). We need to move the isolate creation to a
          // different function to avoid capturing `this` in the closure
          // context.
          Future<List<(int, DartdocEntry)>> process(
            String query,
            List<DartdocEntry> entries, {
            required int periodCount,
          }) {
            return Isolate.run(() {
              final results = entries
                  // Filter elements we search for based on what the query looks
                  // like:
                  // - `element` => include libraries and top level elements
                  // - `container.element` => include top level elements and
                  //                          class members
                  // - `full.qualified.name` => include everything
                  .where(
                    (e) => switch (periodCount) {
                      0 =>
                        e.enclosedBy == null || e.enclosedBy?.type == 'library',
                      1 => e.enclosedBy != null,
                      _ => true,
                    },
                  )
                  .map(
                    (e) => (
                      lehvenstein(
                        query,
                        // Decide what to match on based on what the query looks
                        // like:
                        // `element` => simple name
                        // `container.element` => last two parts of the
                        //                        qualified name
                        // `full.qualified.name` => complete qualified name
                        switch (periodCount) {
                          0 => e.name,
                          1 => e.qualifiedName
                              .split('.')
                              .skip('.'.allMatches(e.qualifiedName).length - 1)
                              .join('.'),
                          _ => e.qualifiedName,
                        }
                            .toLowerCase(),
                      ),
                      e,
                    ),
                  )
                  .toList();

              double getWeight(String type) => switch (type) {
                    // Make classes more likely to appear than constructors or
                    // libraries with the same name.
                    'class_' => 1.1,
                    _ => 1,
                  };

              // +1 so that exact matches (distance of 0) still get weighted.
              results.sort(
                (a, b) => ((a.$1 + 1) / getWeight(a.$2.type))
                    .compareTo((b.$1 + 1) / getWeight(b.$2.type)),
              );
              return results;
            });
          }

          final results = await process(
            query.toLowerCase(),
            entries,
            periodCount: periodCount,
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
            break;
          }

          if (search.kind == SearchKind.elementLookup) {
            final topResults =
                results.takeWhile((value) => value.$1 == results.first.$1);

            await event.message.channel.sendMessage(MessageBuilder(
              replyId: event.message.id,
              allowedMentions: AllowedMentions(repliedUser: false),
              content: topResults.map((e) => '$urlBase${e.$2.href}').join('\n'),
            ));
          } else {
            await event.message.channel.sendMessage(MessageBuilder(
              replyId: event.message.id,
              allowedMentions: AllowedMentions(repliedUser: false),
              embeds: [
                EmbedBuilder(
                  title: 'Pub Search Results - ${search.name}',
                  fields: [
                    for (final result in results.take(10).map((e) => e.$2))
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
            break;
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

      logger.info('Sent search result: ${messageLink(event)}');
    }

    client.onMessageCreate.listen((event) async {
      String content = event.message.content;
      content = removeCodeBlocks(content);
      if (parser.parse(content) case Success(:final value)) {
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

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:dart_style/dart_style.dart';
import 'package:mime/mime.dart';
import 'package:nyxx/nyxx.dart';
import 'package:petitparser/petitparser.dart';
import 'package:recase/recase.dart';
import 'package:swan/messages.dart';
import 'package:swan/plugins/base/plugin.dart';
import 'package:swan/plugins/swa/code.dart';
import 'package:swan/plugins/swa/grammar.dart';
import 'package:swan/plugins/swa/model.dart';

typedef SwaSource = ({String? name, String content});

class CompileSwa extends BotPlugin {
  @override
  String get name => 'CompileSwa';

  @override
  String? get helpText => 'Simple Widget Annotation\n\n'
      'To quickly build a Widget tree from SWA, type `.swa >` '
      'followed by your SWA code.\n\n'
      'Example:\n'
      '```swa\n'
      '.swa > Column > [ Center > Icon(Icons.help), Text(\'Hello, world!\') ]\n'
      '```';

  static const int _maxFileSize = 2 * 1024 * 1024;

  final Parser parser = SimpleWidgetAnnotationGrammer().build();

  /// Builds the error message for when a parsing error occurs.
  String failureToMessage(String content, Failure failure) {
    var [line, char] = Token.lineAndColumnOf(
      failure.buffer,
      failure.position,
    );
    line = max(0, line - 1);
    List<String> lines = content.split('\n');
    lines.insert(
      line,
      '${' '.padRight(char)}v [$line,$char]: ${failure.message}',
    );
    return lines.join('\n');
  }

  @override
  FutureOr<void> afterConnect(NyxxGateway client) {
    client.onMessageCreate.listen((event) async {
      if (event.message.author case User(isBot: true)) return;
      List<SwaSource> sources = [];

      RegExp command = RegExp(r'^(?<name>\w+)?.swa\s*(>\s*(?<content>.+))?$');
      RegExpMatch? commandMatch = command.firstMatch(event.message.content);

      if (commandMatch != null) {
        sources.add((
          name: commandMatch.namedGroup('name')?.pascalCase,
          content: commandMatch.namedGroup('content')!,
        ));
      }

      RegExp codeblock =
          RegExp(r'(?<!\\)```swa\s*?(?<content>[\s\S]+?)(?<!\\)```');

      List<RegExpMatch> codeblockMatches =
          codeblock.allMatches(event.message.content).toList();

      for (final match in codeblockMatches) {
        sources.add((
          name: null,
          content: match.namedGroup('content')!,
        ));
      }

      for (final attachment in event.message.attachments) {
        if (!attachment.fileName.endsWith('.swa')) continue;
        if (attachment.size > _maxFileSize) {
          await event.message.channel.sendMessage(
            MessageBuilder(
              content:
                  'To balance server load, we limit the size of files to {$_maxFileSize}.\n'
                  'File ${attachment.fileName} is too large (${attachment.size} bytes).',
              replyId: event.message.id,
              allowedMentions: AllowedMentions(repliedUser: false),
            ),
          );
          logger.warning(
            'File size too large: ${attachment.size} > 2MB:\n${event.link}',
          );
          return;
        }
        Uint8List bytes = await attachment.fetch();
        String? type = lookupMimeType(attachment.fileName, headerBytes: bytes);
        if (type == null || !type.startsWith('text/')) {
          await event.message.channel.sendMessage(
            MessageBuilder(
              content:
                  'We only support text files. File ${attachment.fileName} is not a text file.',
              replyId: event.message.id,
              allowedMentions: AllowedMentions(repliedUser: false),
            ),
          );
        }
        String content = utf8.decode(bytes);
        sources.add((
          name: attachment.fileName.pascalCase,
          content: content,
        ));
      }

      sources = sources.toSet().toList();

      if (sources.length > 5) {
        sources = sources.take(5).toList();
        await event.message.channel.sendMessage(
          MessageBuilder(
            content:
                'To prevent spam, we limit the number of SWA sources per message to 5.\n'
                'Only the first 5 sources will be compiled.',
            replyId: event.message.id,
            allowedMentions: AllowedMentions(repliedUser: false),
          ),
        );
      }

      for (final source in sources) {
        await compile(event, source);
      }
    });
  }

  Future<void> compile(MessageCreateEvent event, SwaSource source) async {
    String link = event.link;
    final (:name, :content) = source;
    if (content.isEmpty) {
      await event.message.channel.sendMessage(
        MessageBuilder(
          content: helpText,
          replyId: event.message.id,
          allowedMentions: AllowedMentions(repliedUser: false),
        ),
      );
      logger.info('Sent SWA help message:\n$link');
      return;
    }
    Result result;
    try {
      result = parser.parse(content);
    } on Object catch (e, stackTrace) {
      await event.message.channel.sendMessage(
        MessageBuilder(
          content: errorMessage(e, stackTrace),
          replyId: event.message.id,
          allowedMentions: AllowedMentions(repliedUser: false),
        ),
      );
      logger.severe(
        '[#${e.hashCode}] Unexpected error occured when parsing message:\n$link',
        e,
        stackTrace,
      );
      return;
    }
    if (result is Failure) {
      String output = failureToMessage(content, result);
      await event.message.channel.sendMessage(
        MessageBuilder(
          content: 'Failed to parse your message. Error:\n```\n$output\n```',
          replyId: event.message.id,
          allowedMentions: AllowedMentions(repliedUser: false),
        ),
      );
      logger.warning('Failed to parse message:\n$link');
    } else {
      logger.info('Successfully parsed message:\n$link');
      SimpleWidgetAnnotation annotation =
          result.value as SimpleWidgetAnnotation;
      if (name != null && name.isNotEmpty) {
        annotation = SimpleWidgetAnnotation(
          name: name,
          children: [annotation],
        );
      }
      annotation = annotation.toCode();
      String output = annotation.toString();
      output = 'final output = $output;';
      output = DartFormatter().format(output);
      output = output.replaceFirst('final output = ', '');
      if (output.length < kMaxMessageLength) {
        await event.message.channel.sendMessage(
          MessageBuilder(
            content: '```dart\n$output\n```',
            replyId: event.message.id,
            allowedMentions: AllowedMentions(repliedUser: false),
          ),
        );
      } else {
        await event.message.channel.sendMessage(
          MessageBuilder(
            attachments: [
              AttachmentBuilder(
                fileName: 'output.dart',
                data: Uint8List.fromList(utf8.encode(output)),
              ),
            ],
            replyId: event.message.id,
            allowedMentions: AllowedMentions(repliedUser: false),
          ),
        );
      }
    }
  }
}

import 'dart:async';
import 'dart:math';

import 'package:dart_style/dart_style.dart';
import 'package:nyxx/nyxx.dart';
import 'package:petitparser/petitparser.dart';
import 'package:recase/recase.dart';
import 'package:swan/code.dart';
import 'package:swan/grammar.dart';
import 'package:swan/messages.dart';
import 'package:swan/plugin.dart';

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

  Parser parser = SimpleWidgetAnnotationGrammer().build();

  Logger logger = Logger('CompileSwa');

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
  FutureOr<void> onReady(covariant NyxxGateway client) {
    client.onMessageCreate.listen((event) async {
      if (event.message.author case User(isBot: true)) return;
      String link = event.link;
      RegExp command = RegExp(r'^(?<name>\w+)?.swa\s*(>\s*(?<content>.+))?$');
      RegExpMatch? match = command.firstMatch(event.message.content);
      if (match != null) {
        String? inside = match.namedGroup('content');
        String? name = match.namedGroup('name')?.pascalCase;
        if (inside == null || inside.isEmpty) {
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
          result = parser.parse(inside);
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
          String output = failureToMessage(inside, result);
          await event.message.channel.sendMessage(
            MessageBuilder(
              content:
                  'Failed to parse your message. Error:\n```\n$output\n```',
              replyId: event.message.id,
              allowedMentions: AllowedMentions(repliedUser: false),
            ),
          );
          logger.warning('Failed to parse message:\n$link');
        } else {
          logger.info('Successfully parsed message:\n$link');
          SimpleWidgetAnnotation annotation =
              result.value as SimpleWidgetAnnotation;
          if (name != null) {
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
          await event.message.channel.sendMessage(
            MessageBuilder(
              content: '```dart\n$output\n```',
              replyId: event.message.id,
              allowedMentions: AllowedMentions(repliedUser: false),
            ),
          );
        }
      }
    });
  }
}

import 'package:dart_style/dart_style.dart';
import 'package:nyxx/nyxx.dart';
import 'package:petitparser/petitparser.dart';
import 'package:recase/recase.dart';
import 'package:swan/code.dart';
import 'package:swan/env.dart';
import 'package:swan/grammar.dart';
import 'package:swan/messages.dart';
import 'package:swan/logs.dart';

void main() {
  Environment env = Environment.load();

  log('Starting bot...');

  final bot = NyxxFactory.createNyxxWebsocket(
    env.token,
    GatewayIntents.allUnprivileged | GatewayIntents.messageContent,
    options: ClientOptions(
      initialPresence: PresenceBuilder.of(
        status: UserStatus.online,
        activity: ActivityBuilder(
          'Generating code | .swan',
          ActivityType.game,
        ),
      ),
    ),
  )
    ..registerPlugin(Logging())
    ..registerPlugin(CliIntegration())
    ..registerPlugin(IgnoreExceptions())
    ..connect();

  final parser = SimpleWidgetAnnotationGrammer().build();

  bot.eventsWs.onMessageReceived.listen((event) async {
    if (event.message.author.bot) return;
    ReplyBuilder reply = ReplyBuilder(event.message.id);
    String link = event.link;
    RegExp command = RegExp(r'^(?<name>\w+)?.swa\s*(>\s*(?<content>.+))?$');
    RegExpMatch? match = command.firstMatch(event.message.content);
    if (match != null) {
      String? inside = match.namedGroup('content');
      String? name = match.namedGroup('name')?.pascalCase;
      if (inside == null || inside.isEmpty) {
        await event.message.channel.sendMessage(
          MessageBuilder(
            content: helpMessage(),
            replyBuilder: reply,
            allowedMentions: AllowedMentions(),
          ),
        );
        log(
          'Sent help message:\n$link',
          level: LogLevel.info,
        );
        return;
      }
      Result result;
      try {
        result = parser.parse(inside);
      } catch (e, stackTrace) {
        await event.message.channel.sendMessage(
          MessageBuilder(
            content: errorMessage(e, stackTrace),
            replyBuilder: reply,
            allowedMentions: AllowedMentions(),
          ),
        );
        log(
          'Unexpected error occured when parsing message:\n$link',
          level: LogLevel.error,
          exception: e,
          stackTrace: stackTrace,
        );
        return;
      }
      if (result is Failure) {
        String output = failureToMessage(inside, result);
        await event.message.channel.sendMessage(
          MessageBuilder(
            content: 'Failed to parse your message. Error:\n```\n$output\n```',
            replyBuilder: reply,
            allowedMentions: AllowedMentions(),
          ),
        );
        log(
          'Failed to parse message:\n$link',
          level: LogLevel.warning,
        );
      } else {
        log(
          'Successfully parsed message:\n$link',
          level: LogLevel.info,
        );
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
            replyBuilder: reply,
            allowedMentions: AllowedMentions(),
          ),
        );
      }
    }
  });

  bot.eventsWs.onMessageReactionAdded.listen((event) async {
    IMessage? message = event.message;
    if (message == null) return;
    if (message.author.id != bot.self.id) return;
    Snowflake? owner = message.referencedMessage?.message?.author.id;
    if (owner != event.user.id) return;
    if (event.emoji.encodeForAPI() != '💀') return;
    await message.delete();
  });

  bot.eventsWs.onDisconnect.listen((event) {
    log('Bot disconnected. Reason: ${event.reason}');
  });
}

import 'package:nyxx/nyxx.dart';
import 'package:recase/recase.dart';
import 'package:swan/messages.dart';
import 'package:swan/plugin.dart';

class HelpPlugin extends BotPlugin {
  @override
  String get name => 'Help';

  @override
  String get helpText => 'Displays this message.';

  Logger logger = Logger('HelpPlugin');

  @override
  Future<void> afterConnect(NyxxGateway client) async {
    List<BotPlugin> plugins =
        client.options.plugins.whereType<BotPlugin>().toList();
    client.onMessageCreate.listen((event) async {
      if (event.message.author case User(isBot: true)) return;
      if (RegExp(r'^\.swan').hasMatch(event.message.content)) {
        StringBuffer buffer = StringBuffer();
        buffer.writeln('## Help');
        for (final plugin in plugins) {
          if (plugin.helpText == null) continue;
          buffer.writeln('### ${plugin.name.titleCase}');
          buffer.writeln(plugin.helpText);
        }
        await event.message.channel.sendMessage(
          MessageBuilder(
            content: buffer.toString(),
            replyId: event.message.id,
            allowedMentions: AllowedMentions(repliedUser: false),
          ),
        );
        logger.info('Sent help message:\n${event.link}');
      }
    });
  }
}

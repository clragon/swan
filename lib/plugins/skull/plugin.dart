import 'package:nyxx/nyxx.dart';
import 'package:swan/messages.dart';
import 'package:swan/plugins/base/plugin.dart';

class DeleteByReaction extends BotPlugin {
  @override
  String get name => 'DeleteByReaction';

  @override
  String? get helpText => 'Delete bot messages by reacting to them with 💀.';

  late Logger logger = Logger(name);

  @override
  Future<void> afterConnect(NyxxGateway client) async {
    Snowflake id = (await client.users.fetchCurrentUser()).id;
    client.onMessageReactionAdd.listen((event) async {
      Message message = await event.message.get();
      if (message.author.id != id) return;
      Snowflake? owner = message.referencedMessage?.author.id;
      if (owner != event.userId) return;
      if (event.emoji.name != '💀') return;
      await message.delete();
      logger.info('Deleted message 💀:\n${messageLink(message)}');
    });
  }
}

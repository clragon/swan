import 'package:drift/drift.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_extensions/nyxx_extensions.dart';
import 'package:swan/plugins/base/messages.dart';
import 'package:swan/plugins/base/plugin.dart';
import 'package:swan/plugins/database/database.dart';
import 'package:swan/plugins/database/plugin.dart';
import 'package:swan/plugins/env/plugin.dart';

class DeleteByReaction extends BotPlugin {
  @override
  String get name => 'DeleteByReaction';

  @override
  String? buildHelpText(NyxxGateway client) =>
      'Delete bot messages by reacting to them with 💀.\n\n'
      'To enable this plugin for other bots, set the bots role ID: '
      '`${client.env.commandPrefix}bots-role @role`';

  @override
  late Logger logger = Logger(name);

  @override
  Future<void> afterConnect(NyxxGateway client) async {
    client.onMessageCreate.listen((event) => _tryUpdateConfig(client, event));

    client.onMessageReactionAdd.listen((event) async {
      if (event.emoji.name != '💀') return;

      PartialGuild? guild = event.guild;
      if (guild == null) return;

      Message message = await event.message.get();
      MessageAuthor author = message.author;
      if (author is! User) return;

      Snowflake? owner = message.referencedMessage?.author.id;
      if (owner != event.userId) return;

      Member authorMember = await guild.members[author.id].get();

      BotsRoleConfig? config =
          await client.db.botsRoleConfig(guild.id.value).first;

      bool isBotMessage = switch (config) {
        BotsRoleConfig(:final botsRoleId) =>
          authorMember.roleIds.contains(botsRoleId),
        _ => author.id == client.user.id,
      };
      if (!isBotMessage) return;

      await message.delete();
      logger.info('Deleted message 💀:\n${message.id}');
    });
  }

  void _tryUpdateConfig(NyxxGateway client, MessageCreateEvent event) async {
    RegExp command = RegExp(
      r'^'
      '${client.env.commandPrefix}'
      r'bots-role\s+'
      r'<@&(?<role>\d+)>\s*'
      r'$',
    );

    RegExpMatch? match = command.firstMatch(event.message.content);

    if (match == null) return;

    final member = await event.member?.get();
    if (member == null) return;

    final channel = await event.message.channel.get();
    if (channel is! GuildChannel) return;

    final guild = await event.guild?.get();
    if (guild == null) return;

    final permissions = await channel.computePermissionsFor(member);
    if (!permissions.canManageGuild) return;

    try {
      Snowflake botsRoleId = Snowflake.parse(match.namedGroup('role')!);

      client.db.setBotsRoleConfig(BotsRoleConfigsCompanion.insert(
        guildId: Value(guild.id.value),
        botsRoleId: botsRoleId.value,
      ));

      await (channel as TextChannel).sendMessage(MessageBuilder(
        referencedMessage: MessageReferenceBuilder.reply(
          messageId: event.message.id,
        ),
        content: 'Set bots role to ${roleMention(botsRoleId)}',
      ));

      logger.info('Updated config for ${guild.id}: bot role ID $botsRoleId');
    } on FormatException {
      await (channel as TextChannel).sendMessage(MessageBuilder(
        referencedMessage: MessageReferenceBuilder.reply(
          messageId: event.message.id,
        ),
        content: "Couldn't parse channel IDs.",
      ));
      logger.warning('Failed to parse bot role ID from:\n${event.link}');
    }
  }
}

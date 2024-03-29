import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:nyxx/nyxx.dart';
import 'package:swan/plugins/anti_spam/plugin.dart';
import 'package:swan/plugins/base/messages.dart';
import 'package:swan/plugins/base/plugin.dart';
import 'package:swan/plugins/database/database.dart';
import 'package:swan/plugins/database/plugin.dart';
import 'package:swan/plugins/env/plugin.dart';

class AntiSiege extends BotPlugin {
  @override
  String get name => 'AntiSiege';

  @override
  String? buildHelpText(NyxxGateway client) {
    return 'When enabled, users who join and have a low account age will be kicked or banned.\n\n'
        'To enable this plugin, set the appropriate channels: '
        '`${client.env.commandPrefix}anti-siege #mod-logs`\n'
        'To disable this plugin, use `${client.env.commandPrefix}anti-siege off`';
  }

  static const Duration _accountAgeThreshold = Duration(hours: 5);

  @override
  void afterConnect(NyxxGateway client) {
    super.afterConnect(client);

    client.onMessageCreate.listen((event) => _tryUpdateConfig(client, event));

    client.onGuildMemberAdd.listen((event) async {
      final guild = await event.guild.get();
      final member = await event.member.get();

      final config = await client.db.antiSiegeConfig(guild.id.value).first;
      if (config == null) return;

      final logChannel = await client.channels[Snowflake(config.logChannelId)]
          .fetch() as TextChannel;

      final user = await member.user?.get();
      if (user == null) return;
      if (user.isBot) return;

      final accountAge = DateTime.now().difference(user.id.timestamp);

      if (accountAge > _accountAgeThreshold) return;

      Role? role = guild.roleList.firstWhereOrNull((e) => e.name == 'early');
      role ??= await guild.roles.create(
        RoleBuilder(name: 'early'),
      );

      await member.addRole(role.id);
      await member.update(
        MemberUpdateBuilder(
          communicationDisabledUntil:
              DateTime.now().add(const Duration(minutes: 60)).toUtc(),
        ),
      );

      logger.info(
        'Muted ${user.id} for having an account younger than ${_accountAgeThreshold.inMinutes} minutes.',
      );

      await logChannel.sendMessage(MessageBuilder(
        embeds: [
          EmbedBuilder(
            color: DiscordColor.parseHexString('#03d7fc'),
            title: 'Anti-Siege',
            description:
                'Muted <@${user.id}> for having an account younger than ${_accountAgeThreshold.inMinutes} minutes.',
          ),
        ],
      ));
    });
  }

  void _tryUpdateConfig(NyxxGateway client, MessageCreateEvent event) async {
    RegExp command = RegExp(
      r'^'
      '${client.env.commandPrefix}'
      r'anti-siege\s+'
      r'(?<logs>(<#(\d+)>)|off)?\s*'
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

    final permissions = await computePermissions(guild, channel, member);
    if (!permissions.canManageGuild) return;

    try {
      final String? mode = match.namedGroup('logs');
      if (mode == null || mode.isEmpty) {
        logger.info('No log channel provided for anti-siege mode.');
        await (channel as TextChannel).sendMessage(MessageBuilder(
          replyId: event.message.id,
          content: 'Please provide a log channel.',
        ));
        return;
      }

      if (mode == 'off') {
        logger.info('Disabled anti-siege mode for ${guild.id}');
        client.db.deleteAntiSiegeConfig(guild.id.value);
        await (channel as TextChannel).sendMessage(MessageBuilder(
          replyId: event.message.id,
          content: 'Disabled anti-siege mode.',
        ));
        return;
      }

      Snowflake logChannelId =
          Snowflake.parse(mode.substring(2, mode.length - 1));

      client.db.setAntiSiegeConfig(
        AntiSiegeConfigsCompanion.insert(
          guildId: Value(guild.id.value),
          logChannelId: logChannelId.value,
        ),
      );

      logger.info(
          'Enabled anti-siege mode for ${guild.id}. log in $logChannelId');
      await (channel as TextChannel).sendMessage(MessageBuilder(
        replyId: event.message.id,
        content:
            'Enabled anti-siege mode. Logs will be sent to <#$logChannelId>',
      ));
    } on FormatException {
      await (channel as TextChannel).sendMessage(MessageBuilder(
        replyId: event.message.id,
        content: "Couldn't parse channel IDs.",
      ));
      logger.warning('Failed to parse anti-siege config from:\n${event.link}');
    }
  }
}

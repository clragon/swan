import 'dart:collection';

import 'package:drift/drift.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_extensions/nyxx_extensions.dart';
import 'package:swan/plugins/base/plugin.dart';
import 'package:swan/plugins/database/database.dart';
import 'package:swan/plugins/database/plugin.dart';
import 'package:swan/plugins/env/plugin.dart';

class AntiSpam extends BotPlugin {
  static const cacheSize = 5;

  @override
  String get name => 'AntiSpam';

  @override
  String buildHelpText(NyxxGateway client) =>
      'Moderates spam by warning users if they repeat messages in multiple'
      ' channels, and bans users if they repeat messages too many times.\n\n'
      'Admins can configure the rules and warning channel using '
      '`${client.env.commandPrefix}warn-in warning-channel-id rules-channel-id`';

  final Map<Snowflake, Map<Snowflake, Queue<(Snowflake, String)>>> _messages =
      {};

  @override
  void afterConnect(NyxxGateway client) {
    super.afterConnect(client);

    client.onMessageCreate.listen((event) => _tryUpdateConfig(client, event));

    client.onGuildCreate.listen((event) async {
      if (event is! GuildCreateEvent) return;

      Future<Queue<(Snowflake, String)>> fetchInitialCache(
        TextChannel channel,
      ) async {
        try {
          return Queue.of(
            (await channel.messages.fetchMany(limit: cacheSize)).map(
              (e) => (e.author.id, e.content),
            ),
          );
        } on HttpResponseError {
          // Couldn't read messages, bot cannot see channel
          return Queue();
        }
      }

      _messages[event.guild.id] = {
        for (final channel in event.channels.whereType<TextChannel>())
          channel.id: await fetchInitialCache(channel),
      };

      logger.info('Populated message cache for ${event.guild.id}');
    });

    client.onMessageCreate.listen((event) async {
      if (event.guild == null) return;

      final checkedContent = await sanitizeContent(
        event.message.content,
        channel: event.message.channel,
        action: SanitizerAction.remove,
      );

      if (checkedContent.length < 20) return;

      final guildChannels = _messages[event.guild!.id] ??= {};
      int count = 0;
      for (final messages in guildChannels.entries
          .where((element) => element.key != event.message.channel.id)
          .map((e) => e.value)) {
        if (messages.contains(
          (event.message.author.id, event.message.content),
        )) {
          count++;
        }
      }

      if (count != 0) {
        final config =
            await client.db.antiSpamConfig(event.guild!.id.value).first;

        if (config == null) return;

        final warningChannel =
            (client.channels[Snowflake(config.warningChannelId)]
                as PartialTextChannel);

        if (count < 6) {
          await warningChannel.sendMessage(
            MessageBuilder(
              content:
                  'Hey, <@${event.message.author.id}>, please take a second to '
                  'read the <#${config.rulesChannelId}>,\nspecifically, the '
                  'section about not duplicating your messages across channels.'
                  '\nIf you want to move a message, copy it, delete it, **then** '
                  'paste it in another channel.\n\nThanks!',
            ),
          );

          logger.info('Warned ${event.message.author.id} ($count reposts)');
        } else {
          try {
            await event.guild!.createBan(
              event.message.author.id,
              auditLogReason: 'Excessive spam',
              deleteMessages: const Duration(hours: 1),
            );

            logger.info('Banned ${event.message.author.id} ($count reposts)');
          } on HttpResponseError catch (e) {
            logger.warning(
                "Couldn't ban ${event.message.author.id} ($count reposts): ${e.message}");
          }
        }
      }

      final messageQueue = guildChannels[event.message.channel.id] ??= Queue();

      messageQueue.addFirst((event.message.author.id, event.message.content));
      if (messageQueue.length > cacheSize) messageQueue.removeLast();
    });
  }

  void _tryUpdateConfig(NyxxGateway client, MessageCreateEvent event) async {
    if (!event.message.content
        .startsWith('${client.env.commandPrefix}warn-in ')) {
      return;
    }

    final member = await event.member?.get();
    if (member == null) return;

    final channel = await event.message.channel.get();
    if (channel is! GuildChannel) return;

    final guild = await event.guild?.get();
    if (guild == null) return;

    final permissions = await computePermissions(guild, channel, member);
    if (!permissions.canManageGuild) return;

    try {
      final rest = event.message.content
          .substring(client.env.commandPrefix.length + 8)
          .trim();

      final [warnChannelId, rulesChannelId] =
          rest.split(RegExp(r'\s+')).map(Snowflake.parse).toList();

      client.db.setAntiSpamConfig(
        AntiSpamConfigsCompanion.insert(
          guildId: Value(guild.id.value),
          warningChannelId: warnChannelId.value,
          rulesChannelId: rulesChannelId.value,
        ),
      );

      await (channel as TextChannel).sendMessage(MessageBuilder(
        replyId: event.message.id,
        content:
            'Set warning channel to <#$warnChannelId> and rule channel to <#$rulesChannelId>',
      ));

      logger.info(
          'Updated config for ${guild.id}: warn in $warnChannelId, rules channel $rulesChannelId');
    } on FormatException {
      await (channel as TextChannel).sendMessage(MessageBuilder(
        replyId: event.message.id,
        content: "Couldn't parse channel IDs.",
      ));
    }
  }
}

Future<Permissions> computePermissions(
  Guild guild,
  GuildChannel channel,
  Member member,
) async {
  Future<Permissions> computeBasePermissions() async {
    if (guild.ownerId == member.id) {
      return Permissions.allPermissions;
    }

    final everyoneRole = await guild.roles[guild.id].get();
    Flags<Permissions> permissions = everyoneRole.permissions;

    for (final role in member.roles) {
      final rolePermissions = (await role.get()).permissions;

      permissions |= rolePermissions;
    }

    permissions = Permissions(permissions.value);
    permissions as Permissions;

    if (permissions.isAdministrator) {
      return Permissions.allPermissions;
    }

    return permissions;
  }

  Future<Permissions> computeOverwrites(Permissions basePermissions) async {
    if (basePermissions.isAdministrator) {
      return Permissions.allPermissions;
    }

    Flags<Permissions> permissions = basePermissions;

    final everyoneOverwrite = channel.permissionOverwrites
        .where((overwrite) => overwrite.id == guild.id)
        .singleOrNull;
    if (everyoneOverwrite != null) {
      permissions &= ~everyoneOverwrite.deny;
      permissions |= everyoneOverwrite.allow;
    }

    Flags<Permissions> allow = const Permissions(0);
    Flags<Permissions> deny = const Permissions(0);

    for (final roleId in member.roleIds) {
      final roleOverwrite = channel.permissionOverwrites
          .where((overwrite) => overwrite.id == roleId)
          .singleOrNull;
      if (roleOverwrite != null) {
        allow |= roleOverwrite.allow;
        deny |= roleOverwrite.deny;
      }
    }

    permissions &= ~deny;
    permissions |= allow;

    final memberOverwrite = channel.permissionOverwrites
        .where((overwrite) => overwrite.id == member.id)
        .singleOrNull;
    if (memberOverwrite != null) {
      permissions &= ~memberOverwrite.deny;
      permissions |= memberOverwrite.allow;
    }

    return Permissions(permissions.value);
  }

  return computeOverwrites(await computeBasePermissions());
}

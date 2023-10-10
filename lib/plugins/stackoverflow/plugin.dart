import 'dart:async';

import 'package:nyxx/nyxx.dart';
import 'package:swan/messages.dart';
import 'package:swan/plugins/base/plugin.dart';
import 'package:swan/plugins/env/plugin.dart';
import 'package:swan/plugins/stackoverflow/client.dart';
import 'package:swan/plugins/stackoverflow/post.dart';

class StackOverflowMirror extends BotPlugin {
  @override
  String get name => 'StackOverflow';

  @override
  String? buildHelpText(NyxxGateway client) {
    String prefix = client.env.commandPrefix;
    return 'Print a StackOverflow post by link.\n\n'
        '- Using the command `${prefix}flow <link>`\n'
        '- Reply to a message containing a StackOverflow link with `${prefix}flow`';
  }

  @override
  FutureOr<void> afterConnect(NyxxGateway client) {
    client.onMessageCreate.listen((event) async {
      String prefix = client.env.commandPrefix;
      RegExp links = RegExp(
        r'https:\/\/stackoverflow\.com\/questions\/\d+\/\S+',
      );
      RegExp command = RegExp(
        r'^' +
            RegExp.escape(prefix) +
            r'flow\s*' +
            r'(?<link>' +
            links.pattern +
            r')?',
      );
      if (event.message.author case User(isBot: true)) return;
      RegExpMatch? commandMatch = command.firstMatch(event.message.content);
      if (commandMatch != null) {
        String? link = commandMatch.namedGroup('link');
        if (link == null) {
          Message? message = event.message.referencedMessage;
          if (message != null) {
            RegExpMatch? linkMatch = links.firstMatch(message.content);
            if (linkMatch != null) {
              link = linkMatch.group(0);
            }
          }
        }
        if (link != null) {
          try {
            Uri uri = Uri.parse(link);
            StackOverflowClient stackOverflowClient = StackOverflowClient(
              apiKey: client.env.stackExchangeApiKey,
            );
            int id = int.parse(uri.pathSegments[1]);
            try {
              StackOverflowPost post =
                  await stackOverflowClient.getPost(postId: id);
              String result = postToDiscordMarkdown(post);
              if (result.length > kMaxMessageLength) {
                result = '${result.substring(0, kMaxMessageLength - 3)}...';
              }
              await event.message.channel.sendMessage(
                MessageBuilder(
                  content: result,
                  replyId: event.message.id,
                  allowedMentions: AllowedMentions(repliedUser: false),
                ),
              );
            } on StackOverflowClientException {
              await event.message.channel.sendMessage(
                MessageBuilder(
                  content: 'Failed to load post $id',
                  replyId: event.message.id,
                  allowedMentions: AllowedMentions(repliedUser: false),
                ),
              );
            }
          } on FormatException {
            await event.message.channel.sendMessage(
              MessageBuilder(
                content: 'Invalid link: $link',
                replyId: event.message.id,
                allowedMentions: AllowedMentions(repliedUser: false),
              ),
            );
            return;
          }
        }
      }
    });
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:mime/mime.dart';
import 'package:nyxx/nyxx.dart';
import 'package:swan/plugins/base/messages.dart';
import 'package:swan/plugins/base/plugin.dart';
import 'package:swan/plugins/env/plugin.dart';
import 'package:swan/plugins/paste/client.dart';

class PasteFiles extends BotPlugin {
  @override
  String get name => 'PasteFiles';

  @override
  bool isEnabled(NyxxGateway client) => client.env.pastebinApiKey != null;

  @override
  String? buildHelpText(NyxxGateway client) {
    String prefix = client.env.commandPrefix;
    return 'Create PasteBin links for files.\n\n'
        '- Attach files to your message and send `${prefix}paste`\n'
        '- Reply to a message with files attached with `${prefix}paste`';
  }

  static const int _maxFileSize = 2 * 1024 * 1024;

  @override
  FutureOr<void> afterConnect(NyxxGateway client) async {
    if (!isEnabled(client)) return;
    client.onMessageCreate.listen((event) async {
      String prefix = client.env.commandPrefix;
      if (event.message.author case User(isBot: true)) return;
      RegExp regex = RegExp(r'^' + RegExp.escape(prefix) + r'paste$');
      if (!regex.hasMatch(event.message.content)) return;
      List<Attachment> attachments = event.message.attachments;
      if (attachments.isEmpty) {
        attachments = event.message.referencedMessage?.attachments ?? [];
      }
      if (attachments.isEmpty) {
        await event.message.channel.sendMessage(
          MessageBuilder(
            content: 'We didn\'t find any files attached to your message.\n\n'
                '${buildHelpText(client)}}',
            replyId: event.message.id,
            allowedMentions: AllowedMentions(repliedUser: false),
          ),
        );
        return;
      }

      PastebinClient pastebinClient =
          PastebinClient(client.env.pastebinApiKey!);

      Map<String, String> files = {};
      for (final attachment in attachments) {
        if (attachment.size > _maxFileSize) {
          await event.message.channel.sendMessage(
            MessageBuilder(
              content:
                  'To balance server load, we limit the size of files to {$_maxFileSize}.\n'
                  '`${attachment.fileName}` is too large (${attachment.size} bytes).',
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
        // TODO: this is unreliable, e.g. pubspec.yaml is not text.
        if (type == null || !type.startsWith('text/')) {
          await event.message.channel.sendMessage(
            MessageBuilder(
              content:
                  'We only support text files. `${attachment.fileName}` is not a text file.',
              replyId: event.message.id,
              allowedMentions: AllowedMentions(repliedUser: false),
            ),
          );
          return;
        }
        String content = utf8.decode(bytes);
        files[attachment.fileName] = content;
      }

      Map<String, String> links = {};
      for (final file in files.entries) {
        try {
          String id = await pastebinClient.upload(
            file.value,
            name: file.key,
            language: 'dart',
          );
          links[file.key] = id;
        } on PasteClientException catch (e) {
          await event.message.channel.sendMessage(
            MessageBuilder(
              content: 'Failed to upload file to PasteBin: ${e.message}',
              replyId: event.message.id,
              allowedMentions: AllowedMentions(repliedUser: false),
            ),
          );
          logger.severe('Failed to upload file to PasteBin: ${e.message}');
          return;
        }
      }

      StringBuffer buffer = StringBuffer();
      if (links.length == 1) {
        buffer.write('Your paste is ready: \n');
        buffer.write('<${links.entries.first.value}>');
      } else {
        buffer.write('Here are your files: ');
        for (final entry in links.entries) {
          buffer.write('\n- ${entry.key}: <${entry.value}>');
        }
      }
      await event.message.channel.sendMessage(
        MessageBuilder(
          content: buffer.toString(),
          replyId: event.message.id,
          allowedMentions: AllowedMentions(repliedUser: false),
        ),
      );
      logger.info('Uploaded ${links.length} files to PasteBin');
    });
  }
}

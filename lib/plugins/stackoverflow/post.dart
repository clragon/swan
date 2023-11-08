import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swan/plugins/base/messages.dart';
import 'package:swan/plugins/env/plugin.dart';
import 'package:swan/plugins/paste/client.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class StackOverflowPost with _$StackOverflowPost {
  factory StackOverflowPost({
    required StackOverflowPostOwner owner,
    required int score,
    required int lastActivityDate,
    required int creationDate,
    required int questionId,
    required String bodyMarkdown,
    required String link,
    required String title,
  }) = _StackOverflowPost;

  factory StackOverflowPost.fromJson(Map<String, dynamic> json) =>
      _$StackOverflowPostFromJson(json);
}

@freezed
class StackOverflowPostOwner with _$StackOverflowPostOwner {
  factory StackOverflowPostOwner({
    required String displayName,
    required String link,
  }) = _StackOverflowPostOwner;

  factory StackOverflowPostOwner.fromJson(Map<String, dynamic> json) =>
      _$StackOverflowPostOwnerFromJson(json);
}

Future<String> postToDiscordMarkdown(
  StackOverflowPost post,
  Environment env,
) async {
  String header = '# ${post.title}\n'
      '[${post.owner.displayName}](<${post.owner.link}>) - '
      '${timeago.format(DateTime.fromMillisecondsSinceEpoch(post.creationDate * 1000))} | '
      '${post.score} votes | '
      '[Source](<${post.link}>)\n\n';

  String bodyMarkdown = env.pastebinApiKey == null
      ? post.bodyMarkdown
      : await shortenWithPastebin(
          post.bodyMarkdown,
          PastebinClient(env.pastebinApiKey!),
          kMaxMessageLength - header.length,
        );

  String result = '$header$bodyMarkdown';

  if (result.length > kMaxMessageLength) {
    return '${result.substring(0, kMaxMessageLength - 3)}...';
  }

  return result;
}

// Matches code blocks fenced with ```code``` in group 1 and code blocks
// indented by four spaces in group 2 (SO seems to use the latter quite often).
final codeblockPattern = RegExp(
  r'(?:```(?:dart|)\n((?:.*\n)+?)```)|(?:( {4}.+\n(?:(?: {4}.+\n|\n)*) {4}.+)\n)',
  caseSensitive: false,
);

Future<String> shortenWithPastebin(
  String content,
  PastebinClient client,
  int maxLength,
) async {
  content = content.replaceAll('\r\n', '\n');

  final allMatches = codeblockPattern.allMatches(content);
  // (start, length, content)
  final blocks = List.of(allMatches.map((m) => (
        m.start,
        m.end - m.start,
        m.group(1) ?? m.group(2)!,
      )))
    // Ignore code blocks less than 200 characters long.
    ..removeWhere((element) => element.$2 < 200);

  for (final block in blocks) {
    // Cutting codeblocks that will be cut anyway has no effect
    if (block.$1 > maxLength) break;
    // We've managed to cut out enough blocks to make the content fit
    if (content.length <= maxLength) break;

    final paste = await client.upload(block.$3, language: 'dart');

    final oldLength = content.length;

    String cutPreview = block.$3.trim().split('\n').take(3).join('\n');
    if (cutPreview.length > 200) {
      // Ellipsis is already included in the template
      cutPreview = cutPreview.substring(0, 200);
    }

    content = content.replaceRange(block.$1, block.$1 + block.$2, '''
[[see full code]](<$paste>).
```dart
${cutPreview.trim()}
// ...
```
''');

    final cutLength = oldLength - content.length;

    // Update indices of all blocks after this one
    for (final (index, otherBlock) in blocks.indexed) {
      // Cuts only affect blocks after the current one.
      if (otherBlock.$1 > block.$1) {
        blocks[index] =
            (otherBlock.$1 - cutLength, otherBlock.$2, otherBlock.$3);
      }
    }
  }

  return content;
}

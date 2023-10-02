import 'package:freezed_annotation/freezed_annotation.dart';
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

String postToDiscordMarkdown(StackOverflowPost post) {
  return '# ${post.title}\n'
      '[${post.owner.displayName}](<${post.owner.link}>) - '
      '${timeago.format(DateTime.fromMillisecondsSinceEpoch(post.creationDate * 1000))} | '
      '${post.score} votes | '
      '[Source](<${post.link}>)\n\n'
      '${post.bodyMarkdown}';
}

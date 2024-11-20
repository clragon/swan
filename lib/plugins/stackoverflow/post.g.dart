// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StackOverflowPostImpl _$$StackOverflowPostImplFromJson(
        Map<String, dynamic> json) =>
    _$StackOverflowPostImpl(
      owner: StackOverflowPostOwner.fromJson(
          json['owner'] as Map<String, dynamic>),
      score: (json['score'] as num).toInt(),
      lastActivityDate: (json['last_activity_date'] as num).toInt(),
      creationDate: (json['creation_date'] as num).toInt(),
      questionId: (json['question_id'] as num).toInt(),
      bodyMarkdown: json['body_markdown'] as String,
      link: json['link'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$$StackOverflowPostImplToJson(
        _$StackOverflowPostImpl instance) =>
    <String, dynamic>{
      'owner': instance.owner,
      'score': instance.score,
      'last_activity_date': instance.lastActivityDate,
      'creation_date': instance.creationDate,
      'question_id': instance.questionId,
      'body_markdown': instance.bodyMarkdown,
      'link': instance.link,
      'title': instance.title,
    };

_$StackOverflowPostOwnerImpl _$$StackOverflowPostOwnerImplFromJson(
        Map<String, dynamic> json) =>
    _$StackOverflowPostOwnerImpl(
      displayName: json['display_name'] as String,
      link: json['link'] as String,
    );

Map<String, dynamic> _$$StackOverflowPostOwnerImplToJson(
        _$StackOverflowPostOwnerImpl instance) =>
    <String, dynamic>{
      'display_name': instance.displayName,
      'link': instance.link,
    };

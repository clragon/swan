// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StackOverflowPost _$StackOverflowPostFromJson(Map<String, dynamic> json) {
  return _StackOverflowPost.fromJson(json);
}

/// @nodoc
mixin _$StackOverflowPost {
  StackOverflowPostOwner get owner => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get lastActivityDate => throw _privateConstructorUsedError;
  int get creationDate => throw _privateConstructorUsedError;
  int get questionId => throw _privateConstructorUsedError;
  String get bodyMarkdown => throw _privateConstructorUsedError;
  String get link => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  /// Serializes this StackOverflowPost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StackOverflowPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StackOverflowPostCopyWith<StackOverflowPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StackOverflowPostCopyWith<$Res> {
  factory $StackOverflowPostCopyWith(
          StackOverflowPost value, $Res Function(StackOverflowPost) then) =
      _$StackOverflowPostCopyWithImpl<$Res, StackOverflowPost>;
  @useResult
  $Res call(
      {StackOverflowPostOwner owner,
      int score,
      int lastActivityDate,
      int creationDate,
      int questionId,
      String bodyMarkdown,
      String link,
      String title});

  $StackOverflowPostOwnerCopyWith<$Res> get owner;
}

/// @nodoc
class _$StackOverflowPostCopyWithImpl<$Res, $Val extends StackOverflowPost>
    implements $StackOverflowPostCopyWith<$Res> {
  _$StackOverflowPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StackOverflowPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? owner = null,
    Object? score = null,
    Object? lastActivityDate = null,
    Object? creationDate = null,
    Object? questionId = null,
    Object? bodyMarkdown = null,
    Object? link = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as StackOverflowPostOwner,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      lastActivityDate: null == lastActivityDate
          ? _value.lastActivityDate
          : lastActivityDate // ignore: cast_nullable_to_non_nullable
              as int,
      creationDate: null == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as int,
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      bodyMarkdown: null == bodyMarkdown
          ? _value.bodyMarkdown
          : bodyMarkdown // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of StackOverflowPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StackOverflowPostOwnerCopyWith<$Res> get owner {
    return $StackOverflowPostOwnerCopyWith<$Res>(_value.owner, (value) {
      return _then(_value.copyWith(owner: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StackOverflowPostImplCopyWith<$Res>
    implements $StackOverflowPostCopyWith<$Res> {
  factory _$$StackOverflowPostImplCopyWith(_$StackOverflowPostImpl value,
          $Res Function(_$StackOverflowPostImpl) then) =
      __$$StackOverflowPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StackOverflowPostOwner owner,
      int score,
      int lastActivityDate,
      int creationDate,
      int questionId,
      String bodyMarkdown,
      String link,
      String title});

  @override
  $StackOverflowPostOwnerCopyWith<$Res> get owner;
}

/// @nodoc
class __$$StackOverflowPostImplCopyWithImpl<$Res>
    extends _$StackOverflowPostCopyWithImpl<$Res, _$StackOverflowPostImpl>
    implements _$$StackOverflowPostImplCopyWith<$Res> {
  __$$StackOverflowPostImplCopyWithImpl(_$StackOverflowPostImpl _value,
      $Res Function(_$StackOverflowPostImpl) _then)
      : super(_value, _then);

  /// Create a copy of StackOverflowPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? owner = null,
    Object? score = null,
    Object? lastActivityDate = null,
    Object? creationDate = null,
    Object? questionId = null,
    Object? bodyMarkdown = null,
    Object? link = null,
    Object? title = null,
  }) {
    return _then(_$StackOverflowPostImpl(
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as StackOverflowPostOwner,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      lastActivityDate: null == lastActivityDate
          ? _value.lastActivityDate
          : lastActivityDate // ignore: cast_nullable_to_non_nullable
              as int,
      creationDate: null == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as int,
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      bodyMarkdown: null == bodyMarkdown
          ? _value.bodyMarkdown
          : bodyMarkdown // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StackOverflowPostImpl implements _StackOverflowPost {
  _$StackOverflowPostImpl(
      {required this.owner,
      required this.score,
      required this.lastActivityDate,
      required this.creationDate,
      required this.questionId,
      required this.bodyMarkdown,
      required this.link,
      required this.title});

  factory _$StackOverflowPostImpl.fromJson(Map<String, dynamic> json) =>
      _$$StackOverflowPostImplFromJson(json);

  @override
  final StackOverflowPostOwner owner;
  @override
  final int score;
  @override
  final int lastActivityDate;
  @override
  final int creationDate;
  @override
  final int questionId;
  @override
  final String bodyMarkdown;
  @override
  final String link;
  @override
  final String title;

  @override
  String toString() {
    return 'StackOverflowPost(owner: $owner, score: $score, lastActivityDate: $lastActivityDate, creationDate: $creationDate, questionId: $questionId, bodyMarkdown: $bodyMarkdown, link: $link, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StackOverflowPostImpl &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.lastActivityDate, lastActivityDate) ||
                other.lastActivityDate == lastActivityDate) &&
            (identical(other.creationDate, creationDate) ||
                other.creationDate == creationDate) &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.bodyMarkdown, bodyMarkdown) ||
                other.bodyMarkdown == bodyMarkdown) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, owner, score, lastActivityDate,
      creationDate, questionId, bodyMarkdown, link, title);

  /// Create a copy of StackOverflowPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StackOverflowPostImplCopyWith<_$StackOverflowPostImpl> get copyWith =>
      __$$StackOverflowPostImplCopyWithImpl<_$StackOverflowPostImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StackOverflowPostImplToJson(
      this,
    );
  }
}

abstract class _StackOverflowPost implements StackOverflowPost {
  factory _StackOverflowPost(
      {required final StackOverflowPostOwner owner,
      required final int score,
      required final int lastActivityDate,
      required final int creationDate,
      required final int questionId,
      required final String bodyMarkdown,
      required final String link,
      required final String title}) = _$StackOverflowPostImpl;

  factory _StackOverflowPost.fromJson(Map<String, dynamic> json) =
      _$StackOverflowPostImpl.fromJson;

  @override
  StackOverflowPostOwner get owner;
  @override
  int get score;
  @override
  int get lastActivityDate;
  @override
  int get creationDate;
  @override
  int get questionId;
  @override
  String get bodyMarkdown;
  @override
  String get link;
  @override
  String get title;

  /// Create a copy of StackOverflowPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StackOverflowPostImplCopyWith<_$StackOverflowPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StackOverflowPostOwner _$StackOverflowPostOwnerFromJson(
    Map<String, dynamic> json) {
  return _StackOverflowPostOwner.fromJson(json);
}

/// @nodoc
mixin _$StackOverflowPostOwner {
  String get displayName => throw _privateConstructorUsedError;
  String get link => throw _privateConstructorUsedError;

  /// Serializes this StackOverflowPostOwner to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StackOverflowPostOwner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StackOverflowPostOwnerCopyWith<StackOverflowPostOwner> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StackOverflowPostOwnerCopyWith<$Res> {
  factory $StackOverflowPostOwnerCopyWith(StackOverflowPostOwner value,
          $Res Function(StackOverflowPostOwner) then) =
      _$StackOverflowPostOwnerCopyWithImpl<$Res, StackOverflowPostOwner>;
  @useResult
  $Res call({String displayName, String link});
}

/// @nodoc
class _$StackOverflowPostOwnerCopyWithImpl<$Res,
        $Val extends StackOverflowPostOwner>
    implements $StackOverflowPostOwnerCopyWith<$Res> {
  _$StackOverflowPostOwnerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StackOverflowPostOwner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? link = null,
  }) {
    return _then(_value.copyWith(
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StackOverflowPostOwnerImplCopyWith<$Res>
    implements $StackOverflowPostOwnerCopyWith<$Res> {
  factory _$$StackOverflowPostOwnerImplCopyWith(
          _$StackOverflowPostOwnerImpl value,
          $Res Function(_$StackOverflowPostOwnerImpl) then) =
      __$$StackOverflowPostOwnerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String displayName, String link});
}

/// @nodoc
class __$$StackOverflowPostOwnerImplCopyWithImpl<$Res>
    extends _$StackOverflowPostOwnerCopyWithImpl<$Res,
        _$StackOverflowPostOwnerImpl>
    implements _$$StackOverflowPostOwnerImplCopyWith<$Res> {
  __$$StackOverflowPostOwnerImplCopyWithImpl(
      _$StackOverflowPostOwnerImpl _value,
      $Res Function(_$StackOverflowPostOwnerImpl) _then)
      : super(_value, _then);

  /// Create a copy of StackOverflowPostOwner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? link = null,
  }) {
    return _then(_$StackOverflowPostOwnerImpl(
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      link: null == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StackOverflowPostOwnerImpl implements _StackOverflowPostOwner {
  _$StackOverflowPostOwnerImpl({required this.displayName, required this.link});

  factory _$StackOverflowPostOwnerImpl.fromJson(Map<String, dynamic> json) =>
      _$$StackOverflowPostOwnerImplFromJson(json);

  @override
  final String displayName;
  @override
  final String link;

  @override
  String toString() {
    return 'StackOverflowPostOwner(displayName: $displayName, link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StackOverflowPostOwnerImpl &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.link, link) || other.link == link));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, displayName, link);

  /// Create a copy of StackOverflowPostOwner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StackOverflowPostOwnerImplCopyWith<_$StackOverflowPostOwnerImpl>
      get copyWith => __$$StackOverflowPostOwnerImplCopyWithImpl<
          _$StackOverflowPostOwnerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StackOverflowPostOwnerImplToJson(
      this,
    );
  }
}

abstract class _StackOverflowPostOwner implements StackOverflowPostOwner {
  factory _StackOverflowPostOwner(
      {required final String displayName,
      required final String link}) = _$StackOverflowPostOwnerImpl;

  factory _StackOverflowPostOwner.fromJson(Map<String, dynamic> json) =
      _$StackOverflowPostOwnerImpl.fromJson;

  @override
  String get displayName;
  @override
  String get link;

  /// Create a copy of StackOverflowPostOwner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StackOverflowPostOwnerImplCopyWith<_$StackOverflowPostOwnerImpl>
      get copyWith => throw _privateConstructorUsedError;
}

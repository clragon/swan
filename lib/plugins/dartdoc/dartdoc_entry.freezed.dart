// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dartdoc_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DartdocEntry _$DartdocEntryFromJson(Map<String, dynamic> json) {
  return _DartdocEntry.fromJson(json);
}

/// @nodoc
mixin _$DartdocEntry {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'qualifiedName')
  String get qualifiedName => throw _privateConstructorUsedError;
  String get href => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _typeFromJson, name: 'kind')
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'desc')
  String get description => throw _privateConstructorUsedError;
  @JsonKey(required: false, name: 'enclosedBy')
  DartdocEnclosedBy? get enclosedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DartdocEntryCopyWith<DartdocEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DartdocEntryCopyWith<$Res> {
  factory $DartdocEntryCopyWith(
          DartdocEntry value, $Res Function(DartdocEntry) then) =
      _$DartdocEntryCopyWithImpl<$Res, DartdocEntry>;
  @useResult
  $Res call(
      {String name,
      @JsonKey(name: 'qualifiedName') String qualifiedName,
      String href,
      @JsonKey(fromJson: _typeFromJson, name: 'kind') String type,
      @JsonKey(name: 'desc') String description,
      @JsonKey(required: false, name: 'enclosedBy')
      DartdocEnclosedBy? enclosedBy});

  $DartdocEnclosedByCopyWith<$Res>? get enclosedBy;
}

/// @nodoc
class _$DartdocEntryCopyWithImpl<$Res, $Val extends DartdocEntry>
    implements $DartdocEntryCopyWith<$Res> {
  _$DartdocEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? qualifiedName = null,
    Object? href = null,
    Object? type = null,
    Object? description = null,
    Object? enclosedBy = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      qualifiedName: null == qualifiedName
          ? _value.qualifiedName
          : qualifiedName // ignore: cast_nullable_to_non_nullable
              as String,
      href: null == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      enclosedBy: freezed == enclosedBy
          ? _value.enclosedBy
          : enclosedBy // ignore: cast_nullable_to_non_nullable
              as DartdocEnclosedBy?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DartdocEnclosedByCopyWith<$Res>? get enclosedBy {
    if (_value.enclosedBy == null) {
      return null;
    }

    return $DartdocEnclosedByCopyWith<$Res>(_value.enclosedBy!, (value) {
      return _then(_value.copyWith(enclosedBy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DartdocEntryImplCopyWith<$Res>
    implements $DartdocEntryCopyWith<$Res> {
  factory _$$DartdocEntryImplCopyWith(
          _$DartdocEntryImpl value, $Res Function(_$DartdocEntryImpl) then) =
      __$$DartdocEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      @JsonKey(name: 'qualifiedName') String qualifiedName,
      String href,
      @JsonKey(fromJson: _typeFromJson, name: 'kind') String type,
      @JsonKey(name: 'desc') String description,
      @JsonKey(required: false, name: 'enclosedBy')
      DartdocEnclosedBy? enclosedBy});

  @override
  $DartdocEnclosedByCopyWith<$Res>? get enclosedBy;
}

/// @nodoc
class __$$DartdocEntryImplCopyWithImpl<$Res>
    extends _$DartdocEntryCopyWithImpl<$Res, _$DartdocEntryImpl>
    implements _$$DartdocEntryImplCopyWith<$Res> {
  __$$DartdocEntryImplCopyWithImpl(
      _$DartdocEntryImpl _value, $Res Function(_$DartdocEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? qualifiedName = null,
    Object? href = null,
    Object? type = null,
    Object? description = null,
    Object? enclosedBy = freezed,
  }) {
    return _then(_$DartdocEntryImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      qualifiedName: null == qualifiedName
          ? _value.qualifiedName
          : qualifiedName // ignore: cast_nullable_to_non_nullable
              as String,
      href: null == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      enclosedBy: freezed == enclosedBy
          ? _value.enclosedBy
          : enclosedBy // ignore: cast_nullable_to_non_nullable
              as DartdocEnclosedBy?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DartdocEntryImpl implements _DartdocEntry {
  _$DartdocEntryImpl(
      {required this.name,
      @JsonKey(name: 'qualifiedName') required this.qualifiedName,
      required this.href,
      @JsonKey(fromJson: _typeFromJson, name: 'kind') required this.type,
      @JsonKey(name: 'desc') required this.description,
      @JsonKey(required: false, name: 'enclosedBy') required this.enclosedBy});

  factory _$DartdocEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DartdocEntryImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: 'qualifiedName')
  final String qualifiedName;
  @override
  final String href;
  @override
  @JsonKey(fromJson: _typeFromJson, name: 'kind')
  final String type;
  @override
  @JsonKey(name: 'desc')
  final String description;
  @override
  @JsonKey(required: false, name: 'enclosedBy')
  final DartdocEnclosedBy? enclosedBy;

  @override
  String toString() {
    return 'DartdocEntry(name: $name, qualifiedName: $qualifiedName, href: $href, type: $type, description: $description, enclosedBy: $enclosedBy)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DartdocEntryImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.qualifiedName, qualifiedName) ||
                other.qualifiedName == qualifiedName) &&
            (identical(other.href, href) || other.href == href) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.enclosedBy, enclosedBy) ||
                other.enclosedBy == enclosedBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, qualifiedName, href, type, description, enclosedBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DartdocEntryImplCopyWith<_$DartdocEntryImpl> get copyWith =>
      __$$DartdocEntryImplCopyWithImpl<_$DartdocEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DartdocEntryImplToJson(
      this,
    );
  }
}

abstract class _DartdocEntry implements DartdocEntry {
  factory _DartdocEntry(
      {required final String name,
      @JsonKey(name: 'qualifiedName') required final String qualifiedName,
      required final String href,
      @JsonKey(fromJson: _typeFromJson, name: 'kind')
      required final String type,
      @JsonKey(name: 'desc') required final String description,
      @JsonKey(required: false, name: 'enclosedBy')
      required final DartdocEnclosedBy? enclosedBy}) = _$DartdocEntryImpl;

  factory _DartdocEntry.fromJson(Map<String, dynamic> json) =
      _$DartdocEntryImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'qualifiedName')
  String get qualifiedName;
  @override
  String get href;
  @override
  @JsonKey(fromJson: _typeFromJson, name: 'kind')
  String get type;
  @override
  @JsonKey(name: 'desc')
  String get description;
  @override
  @JsonKey(required: false, name: 'enclosedBy')
  DartdocEnclosedBy? get enclosedBy;
  @override
  @JsonKey(ignore: true)
  _$$DartdocEntryImplCopyWith<_$DartdocEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DartdocEnclosedBy _$DartdocEnclosedByFromJson(Map<String, dynamic> json) {
  return _DartdocEnclosedBy.fromJson(json);
}

/// @nodoc
mixin _$DartdocEnclosedBy {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _typeFromJson, name: 'kind')
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DartdocEnclosedByCopyWith<DartdocEnclosedBy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DartdocEnclosedByCopyWith<$Res> {
  factory $DartdocEnclosedByCopyWith(
          DartdocEnclosedBy value, $Res Function(DartdocEnclosedBy) then) =
      _$DartdocEnclosedByCopyWithImpl<$Res, DartdocEnclosedBy>;
  @useResult
  $Res call(
      {String name,
      @JsonKey(fromJson: _typeFromJson, name: 'kind') String type});
}

/// @nodoc
class _$DartdocEnclosedByCopyWithImpl<$Res, $Val extends DartdocEnclosedBy>
    implements $DartdocEnclosedByCopyWith<$Res> {
  _$DartdocEnclosedByCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DartdocEnclosedByImplCopyWith<$Res>
    implements $DartdocEnclosedByCopyWith<$Res> {
  factory _$$DartdocEnclosedByImplCopyWith(_$DartdocEnclosedByImpl value,
          $Res Function(_$DartdocEnclosedByImpl) then) =
      __$$DartdocEnclosedByImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      @JsonKey(fromJson: _typeFromJson, name: 'kind') String type});
}

/// @nodoc
class __$$DartdocEnclosedByImplCopyWithImpl<$Res>
    extends _$DartdocEnclosedByCopyWithImpl<$Res, _$DartdocEnclosedByImpl>
    implements _$$DartdocEnclosedByImplCopyWith<$Res> {
  __$$DartdocEnclosedByImplCopyWithImpl(_$DartdocEnclosedByImpl _value,
      $Res Function(_$DartdocEnclosedByImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
  }) {
    return _then(_$DartdocEnclosedByImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DartdocEnclosedByImpl implements _DartdocEnclosedBy {
  _$DartdocEnclosedByImpl(
      {required this.name,
      @JsonKey(fromJson: _typeFromJson, name: 'kind') required this.type});

  factory _$DartdocEnclosedByImpl.fromJson(Map<String, dynamic> json) =>
      _$$DartdocEnclosedByImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(fromJson: _typeFromJson, name: 'kind')
  final String type;

  @override
  String toString() {
    return 'DartdocEnclosedBy(name: $name, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DartdocEnclosedByImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DartdocEnclosedByImplCopyWith<_$DartdocEnclosedByImpl> get copyWith =>
      __$$DartdocEnclosedByImplCopyWithImpl<_$DartdocEnclosedByImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DartdocEnclosedByImplToJson(
      this,
    );
  }
}

abstract class _DartdocEnclosedBy implements DartdocEnclosedBy {
  factory _DartdocEnclosedBy(
      {required final String name,
      @JsonKey(fromJson: _typeFromJson, name: 'kind')
      required final String type}) = _$DartdocEnclosedByImpl;

  factory _DartdocEnclosedBy.fromJson(Map<String, dynamic> json) =
      _$DartdocEnclosedByImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(fromJson: _typeFromJson, name: 'kind')
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$DartdocEnclosedByImplCopyWith<_$DartdocEnclosedByImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

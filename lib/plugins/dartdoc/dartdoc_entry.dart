import 'package:freezed_annotation/freezed_annotation.dart';

part 'dartdoc_entry.g.dart';
part 'dartdoc_entry.freezed.dart';

@freezed
class DartdocEntry with _$DartdocEntry {
  factory DartdocEntry({
    required String name,
    @JsonKey(name: 'qualifiedName') required String qualifiedName,
    required String href,
    @JsonKey(fromJson: _typeFromJson, name: 'kind') required String type,
    @JsonKey(name: 'desc') required String description,
    @JsonKey(required: false, name: 'enclosedBy')
    required DartdocEnclosedBy? enclosedBy,
  }) = _DartdocEntry;

  factory DartdocEntry.fromJson(Map<String, dynamic> json) =>
      _$DartdocEntryFromJson(json);
}

@freezed
class DartdocEnclosedBy with _$DartdocEnclosedBy {
  factory DartdocEnclosedBy({
    required String name,
    @JsonKey(fromJson: _typeFromJson, name: 'kind') required String type,
  }) = _DartdocEnclosedBy;

  factory DartdocEnclosedBy.fromJson(Map<String, dynamic> json) =>
      _$DartdocEnclosedByFromJson(json);
}

String _typeFromJson(int kind) => [
      // https://pub.dev/documentation/dartdoc/latest/dartdoc/Kind.html
      'accessor',
      'constant',
      'constructor',
      'class_',
      'dynamic',
      'enum_',
      'extension',
      // 'extensionType',
      'function',
      'library',
      'method',
      'mixin',
      'never',
      'package',
      'parameter',
      'prefix',
      'property',
      'sdk',
      'topic',
      'topLevelConstant',
      'topLevelProperty',
      'typedef',
      'typeParameter',
    ][kind];

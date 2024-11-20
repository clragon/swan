// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dartdoc_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DartdocEntryImpl _$$DartdocEntryImplFromJson(Map<String, dynamic> json) =>
    _$DartdocEntryImpl(
      name: json['name'] as String,
      qualifiedName: json['qualifiedName'] as String,
      href: json['href'] as String,
      type: _typeFromJson((json['kind'] as num).toInt()),
      description: json['desc'] as String,
      enclosedBy: json['enclosedBy'] == null
          ? null
          : DartdocEnclosedBy.fromJson(
              json['enclosedBy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DartdocEntryImplToJson(_$DartdocEntryImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'qualifiedName': instance.qualifiedName,
      'href': instance.href,
      'kind': instance.type,
      'desc': instance.description,
      'enclosedBy': instance.enclosedBy,
    };

_$DartdocEnclosedByImpl _$$DartdocEnclosedByImplFromJson(
        Map<String, dynamic> json) =>
    _$DartdocEnclosedByImpl(
      name: json['name'] as String,
      type: _typeFromJson((json['kind'] as num).toInt()),
    );

Map<String, dynamic> _$$DartdocEnclosedByImplToJson(
        _$DartdocEnclosedByImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'kind': instance.type,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AntiSpamConfigTable extends AntiSpamConfig
    with TableInfo<$AntiSpamConfigTable, AntiSpamConfigData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AntiSpamConfigTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _guildIdMeta =
      const VerificationMeta('guildId');
  @override
  late final GeneratedColumn<int> guildId = GeneratedColumn<int>(
      'guild_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _warningChannelIdMeta =
      const VerificationMeta('warningChannelId');
  @override
  late final GeneratedColumn<int> warningChannelId = GeneratedColumn<int>(
      'warning_channel_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _rulesChannelIdMeta =
      const VerificationMeta('rulesChannelId');
  @override
  late final GeneratedColumn<int> rulesChannelId = GeneratedColumn<int>(
      'rules_channel_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [guildId, warningChannelId, rulesChannelId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'anti_spam_config';
  @override
  VerificationContext validateIntegrity(Insertable<AntiSpamConfigData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('guild_id')) {
      context.handle(_guildIdMeta,
          guildId.isAcceptableOrUnknown(data['guild_id']!, _guildIdMeta));
    }
    if (data.containsKey('warning_channel_id')) {
      context.handle(
          _warningChannelIdMeta,
          warningChannelId.isAcceptableOrUnknown(
              data['warning_channel_id']!, _warningChannelIdMeta));
    } else if (isInserting) {
      context.missing(_warningChannelIdMeta);
    }
    if (data.containsKey('rules_channel_id')) {
      context.handle(
          _rulesChannelIdMeta,
          rulesChannelId.isAcceptableOrUnknown(
              data['rules_channel_id']!, _rulesChannelIdMeta));
    } else if (isInserting) {
      context.missing(_rulesChannelIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {guildId};
  @override
  AntiSpamConfigData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AntiSpamConfigData(
      guildId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}guild_id'])!,
      warningChannelId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}warning_channel_id'])!,
      rulesChannelId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rules_channel_id'])!,
    );
  }

  @override
  $AntiSpamConfigTable createAlias(String alias) {
    return $AntiSpamConfigTable(attachedDatabase, alias);
  }
}

class AntiSpamConfigData extends DataClass
    implements Insertable<AntiSpamConfigData> {
  final int guildId;
  final int warningChannelId;
  final int rulesChannelId;
  const AntiSpamConfigData(
      {required this.guildId,
      required this.warningChannelId,
      required this.rulesChannelId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['guild_id'] = Variable<int>(guildId);
    map['warning_channel_id'] = Variable<int>(warningChannelId);
    map['rules_channel_id'] = Variable<int>(rulesChannelId);
    return map;
  }

  AntiSpamConfigCompanion toCompanion(bool nullToAbsent) {
    return AntiSpamConfigCompanion(
      guildId: Value(guildId),
      warningChannelId: Value(warningChannelId),
      rulesChannelId: Value(rulesChannelId),
    );
  }

  factory AntiSpamConfigData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AntiSpamConfigData(
      guildId: serializer.fromJson<int>(json['guildId']),
      warningChannelId: serializer.fromJson<int>(json['warningChannelId']),
      rulesChannelId: serializer.fromJson<int>(json['rulesChannelId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'guildId': serializer.toJson<int>(guildId),
      'warningChannelId': serializer.toJson<int>(warningChannelId),
      'rulesChannelId': serializer.toJson<int>(rulesChannelId),
    };
  }

  AntiSpamConfigData copyWith(
          {int? guildId, int? warningChannelId, int? rulesChannelId}) =>
      AntiSpamConfigData(
        guildId: guildId ?? this.guildId,
        warningChannelId: warningChannelId ?? this.warningChannelId,
        rulesChannelId: rulesChannelId ?? this.rulesChannelId,
      );
  @override
  String toString() {
    return (StringBuffer('AntiSpamConfigData(')
          ..write('guildId: $guildId, ')
          ..write('warningChannelId: $warningChannelId, ')
          ..write('rulesChannelId: $rulesChannelId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(guildId, warningChannelId, rulesChannelId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AntiSpamConfigData &&
          other.guildId == this.guildId &&
          other.warningChannelId == this.warningChannelId &&
          other.rulesChannelId == this.rulesChannelId);
}

class AntiSpamConfigCompanion extends UpdateCompanion<AntiSpamConfigData> {
  final Value<int> guildId;
  final Value<int> warningChannelId;
  final Value<int> rulesChannelId;
  const AntiSpamConfigCompanion({
    this.guildId = const Value.absent(),
    this.warningChannelId = const Value.absent(),
    this.rulesChannelId = const Value.absent(),
  });
  AntiSpamConfigCompanion.insert({
    this.guildId = const Value.absent(),
    required int warningChannelId,
    required int rulesChannelId,
  })  : warningChannelId = Value(warningChannelId),
        rulesChannelId = Value(rulesChannelId);
  static Insertable<AntiSpamConfigData> custom({
    Expression<int>? guildId,
    Expression<int>? warningChannelId,
    Expression<int>? rulesChannelId,
  }) {
    return RawValuesInsertable({
      if (guildId != null) 'guild_id': guildId,
      if (warningChannelId != null) 'warning_channel_id': warningChannelId,
      if (rulesChannelId != null) 'rules_channel_id': rulesChannelId,
    });
  }

  AntiSpamConfigCompanion copyWith(
      {Value<int>? guildId,
      Value<int>? warningChannelId,
      Value<int>? rulesChannelId}) {
    return AntiSpamConfigCompanion(
      guildId: guildId ?? this.guildId,
      warningChannelId: warningChannelId ?? this.warningChannelId,
      rulesChannelId: rulesChannelId ?? this.rulesChannelId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (guildId.present) {
      map['guild_id'] = Variable<int>(guildId.value);
    }
    if (warningChannelId.present) {
      map['warning_channel_id'] = Variable<int>(warningChannelId.value);
    }
    if (rulesChannelId.present) {
      map['rules_channel_id'] = Variable<int>(rulesChannelId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AntiSpamConfigCompanion(')
          ..write('guildId: $guildId, ')
          ..write('warningChannelId: $warningChannelId, ')
          ..write('rulesChannelId: $rulesChannelId')
          ..write(')'))
        .toString();
  }
}

abstract class _$SwanDatabase extends GeneratedDatabase {
  _$SwanDatabase(QueryExecutor e) : super(e);
  late final $AntiSpamConfigTable antiSpamConfig = $AntiSpamConfigTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [antiSpamConfig];
}

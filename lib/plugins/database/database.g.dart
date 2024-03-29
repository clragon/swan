// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AntiSpamConfigsTable extends AntiSpamConfigs
    with TableInfo<$AntiSpamConfigsTable, AntiSpamConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AntiSpamConfigsTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'anti_spam_configs';
  @override
  VerificationContext validateIntegrity(Insertable<AntiSpamConfig> instance,
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
  AntiSpamConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AntiSpamConfig(
      guildId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}guild_id'])!,
      warningChannelId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}warning_channel_id'])!,
      rulesChannelId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rules_channel_id'])!,
    );
  }

  @override
  $AntiSpamConfigsTable createAlias(String alias) {
    return $AntiSpamConfigsTable(attachedDatabase, alias);
  }
}

class AntiSpamConfig extends DataClass implements Insertable<AntiSpamConfig> {
  final int guildId;
  final int warningChannelId;
  final int rulesChannelId;
  const AntiSpamConfig(
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

  AntiSpamConfigsCompanion toCompanion(bool nullToAbsent) {
    return AntiSpamConfigsCompanion(
      guildId: Value(guildId),
      warningChannelId: Value(warningChannelId),
      rulesChannelId: Value(rulesChannelId),
    );
  }

  factory AntiSpamConfig.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AntiSpamConfig(
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

  AntiSpamConfig copyWith(
          {int? guildId, int? warningChannelId, int? rulesChannelId}) =>
      AntiSpamConfig(
        guildId: guildId ?? this.guildId,
        warningChannelId: warningChannelId ?? this.warningChannelId,
        rulesChannelId: rulesChannelId ?? this.rulesChannelId,
      );
  @override
  String toString() {
    return (StringBuffer('AntiSpamConfig(')
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
      (other is AntiSpamConfig &&
          other.guildId == this.guildId &&
          other.warningChannelId == this.warningChannelId &&
          other.rulesChannelId == this.rulesChannelId);
}

class AntiSpamConfigsCompanion extends UpdateCompanion<AntiSpamConfig> {
  final Value<int> guildId;
  final Value<int> warningChannelId;
  final Value<int> rulesChannelId;
  const AntiSpamConfigsCompanion({
    this.guildId = const Value.absent(),
    this.warningChannelId = const Value.absent(),
    this.rulesChannelId = const Value.absent(),
  });
  AntiSpamConfigsCompanion.insert({
    this.guildId = const Value.absent(),
    required int warningChannelId,
    required int rulesChannelId,
  })  : warningChannelId = Value(warningChannelId),
        rulesChannelId = Value(rulesChannelId);
  static Insertable<AntiSpamConfig> custom({
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

  AntiSpamConfigsCompanion copyWith(
      {Value<int>? guildId,
      Value<int>? warningChannelId,
      Value<int>? rulesChannelId}) {
    return AntiSpamConfigsCompanion(
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
    return (StringBuffer('AntiSpamConfigsCompanion(')
          ..write('guildId: $guildId, ')
          ..write('warningChannelId: $warningChannelId, ')
          ..write('rulesChannelId: $rulesChannelId')
          ..write(')'))
        .toString();
  }
}

class $AntiSiegeConfigsTable extends AntiSiegeConfigs
    with TableInfo<$AntiSiegeConfigsTable, AntiSiegeConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AntiSiegeConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _guildIdMeta =
      const VerificationMeta('guildId');
  @override
  late final GeneratedColumn<int> guildId = GeneratedColumn<int>(
      'guild_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _logChannelIdMeta =
      const VerificationMeta('logChannelId');
  @override
  late final GeneratedColumn<int> logChannelId = GeneratedColumn<int>(
      'log_channel_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [guildId, logChannelId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'anti_siege_configs';
  @override
  VerificationContext validateIntegrity(Insertable<AntiSiegeConfig> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('guild_id')) {
      context.handle(_guildIdMeta,
          guildId.isAcceptableOrUnknown(data['guild_id']!, _guildIdMeta));
    }
    if (data.containsKey('log_channel_id')) {
      context.handle(
          _logChannelIdMeta,
          logChannelId.isAcceptableOrUnknown(
              data['log_channel_id']!, _logChannelIdMeta));
    } else if (isInserting) {
      context.missing(_logChannelIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {guildId};
  @override
  AntiSiegeConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AntiSiegeConfig(
      guildId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}guild_id'])!,
      logChannelId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}log_channel_id'])!,
    );
  }

  @override
  $AntiSiegeConfigsTable createAlias(String alias) {
    return $AntiSiegeConfigsTable(attachedDatabase, alias);
  }
}

class AntiSiegeConfig extends DataClass implements Insertable<AntiSiegeConfig> {
  final int guildId;
  final int logChannelId;
  const AntiSiegeConfig({required this.guildId, required this.logChannelId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['guild_id'] = Variable<int>(guildId);
    map['log_channel_id'] = Variable<int>(logChannelId);
    return map;
  }

  AntiSiegeConfigsCompanion toCompanion(bool nullToAbsent) {
    return AntiSiegeConfigsCompanion(
      guildId: Value(guildId),
      logChannelId: Value(logChannelId),
    );
  }

  factory AntiSiegeConfig.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AntiSiegeConfig(
      guildId: serializer.fromJson<int>(json['guildId']),
      logChannelId: serializer.fromJson<int>(json['logChannelId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'guildId': serializer.toJson<int>(guildId),
      'logChannelId': serializer.toJson<int>(logChannelId),
    };
  }

  AntiSiegeConfig copyWith({int? guildId, int? logChannelId}) =>
      AntiSiegeConfig(
        guildId: guildId ?? this.guildId,
        logChannelId: logChannelId ?? this.logChannelId,
      );
  @override
  String toString() {
    return (StringBuffer('AntiSiegeConfig(')
          ..write('guildId: $guildId, ')
          ..write('logChannelId: $logChannelId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(guildId, logChannelId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AntiSiegeConfig &&
          other.guildId == this.guildId &&
          other.logChannelId == this.logChannelId);
}

class AntiSiegeConfigsCompanion extends UpdateCompanion<AntiSiegeConfig> {
  final Value<int> guildId;
  final Value<int> logChannelId;
  const AntiSiegeConfigsCompanion({
    this.guildId = const Value.absent(),
    this.logChannelId = const Value.absent(),
  });
  AntiSiegeConfigsCompanion.insert({
    this.guildId = const Value.absent(),
    required int logChannelId,
  }) : logChannelId = Value(logChannelId);
  static Insertable<AntiSiegeConfig> custom({
    Expression<int>? guildId,
    Expression<int>? logChannelId,
  }) {
    return RawValuesInsertable({
      if (guildId != null) 'guild_id': guildId,
      if (logChannelId != null) 'log_channel_id': logChannelId,
    });
  }

  AntiSiegeConfigsCompanion copyWith(
      {Value<int>? guildId, Value<int>? logChannelId}) {
    return AntiSiegeConfigsCompanion(
      guildId: guildId ?? this.guildId,
      logChannelId: logChannelId ?? this.logChannelId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (guildId.present) {
      map['guild_id'] = Variable<int>(guildId.value);
    }
    if (logChannelId.present) {
      map['log_channel_id'] = Variable<int>(logChannelId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AntiSiegeConfigsCompanion(')
          ..write('guildId: $guildId, ')
          ..write('logChannelId: $logChannelId')
          ..write(')'))
        .toString();
  }
}

abstract class _$SwanDatabase extends GeneratedDatabase {
  _$SwanDatabase(QueryExecutor e) : super(e);
  late final $AntiSpamConfigsTable antiSpamConfigs =
      $AntiSpamConfigsTable(this);
  late final $AntiSiegeConfigsTable antiSiegeConfigs =
      $AntiSiegeConfigsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [antiSpamConfigs, antiSiegeConfigs];
}

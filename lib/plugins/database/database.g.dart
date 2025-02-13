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
  AntiSpamConfig copyWithCompanion(AntiSpamConfigsCompanion data) {
    return AntiSpamConfig(
      guildId: data.guildId.present ? data.guildId.value : this.guildId,
      warningChannelId: data.warningChannelId.present
          ? data.warningChannelId.value
          : this.warningChannelId,
      rulesChannelId: data.rulesChannelId.present
          ? data.rulesChannelId.value
          : this.rulesChannelId,
    );
  }

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

class $BotsRoleConfigsTable extends BotsRoleConfigs
    with TableInfo<$BotsRoleConfigsTable, BotsRoleConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BotsRoleConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _guildIdMeta =
      const VerificationMeta('guildId');
  @override
  late final GeneratedColumn<int> guildId = GeneratedColumn<int>(
      'guild_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _botsRoleIdMeta =
      const VerificationMeta('botsRoleId');
  @override
  late final GeneratedColumn<int> botsRoleId = GeneratedColumn<int>(
      'bots_role_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [guildId, botsRoleId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bots_role_configs';
  @override
  VerificationContext validateIntegrity(Insertable<BotsRoleConfig> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('guild_id')) {
      context.handle(_guildIdMeta,
          guildId.isAcceptableOrUnknown(data['guild_id']!, _guildIdMeta));
    }
    if (data.containsKey('bots_role_id')) {
      context.handle(
          _botsRoleIdMeta,
          botsRoleId.isAcceptableOrUnknown(
              data['bots_role_id']!, _botsRoleIdMeta));
    } else if (isInserting) {
      context.missing(_botsRoleIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {guildId};
  @override
  BotsRoleConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BotsRoleConfig(
      guildId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}guild_id'])!,
      botsRoleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bots_role_id'])!,
    );
  }

  @override
  $BotsRoleConfigsTable createAlias(String alias) {
    return $BotsRoleConfigsTable(attachedDatabase, alias);
  }
}

class BotsRoleConfig extends DataClass implements Insertable<BotsRoleConfig> {
  final int guildId;
  final int botsRoleId;
  const BotsRoleConfig({required this.guildId, required this.botsRoleId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['guild_id'] = Variable<int>(guildId);
    map['bots_role_id'] = Variable<int>(botsRoleId);
    return map;
  }

  BotsRoleConfigsCompanion toCompanion(bool nullToAbsent) {
    return BotsRoleConfigsCompanion(
      guildId: Value(guildId),
      botsRoleId: Value(botsRoleId),
    );
  }

  factory BotsRoleConfig.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BotsRoleConfig(
      guildId: serializer.fromJson<int>(json['guildId']),
      botsRoleId: serializer.fromJson<int>(json['botsRoleId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'guildId': serializer.toJson<int>(guildId),
      'botsRoleId': serializer.toJson<int>(botsRoleId),
    };
  }

  BotsRoleConfig copyWith({int? guildId, int? botsRoleId}) => BotsRoleConfig(
        guildId: guildId ?? this.guildId,
        botsRoleId: botsRoleId ?? this.botsRoleId,
      );
  BotsRoleConfig copyWithCompanion(BotsRoleConfigsCompanion data) {
    return BotsRoleConfig(
      guildId: data.guildId.present ? data.guildId.value : this.guildId,
      botsRoleId:
          data.botsRoleId.present ? data.botsRoleId.value : this.botsRoleId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BotsRoleConfig(')
          ..write('guildId: $guildId, ')
          ..write('botsRoleId: $botsRoleId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(guildId, botsRoleId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BotsRoleConfig &&
          other.guildId == this.guildId &&
          other.botsRoleId == this.botsRoleId);
}

class BotsRoleConfigsCompanion extends UpdateCompanion<BotsRoleConfig> {
  final Value<int> guildId;
  final Value<int> botsRoleId;
  const BotsRoleConfigsCompanion({
    this.guildId = const Value.absent(),
    this.botsRoleId = const Value.absent(),
  });
  BotsRoleConfigsCompanion.insert({
    this.guildId = const Value.absent(),
    required int botsRoleId,
  }) : botsRoleId = Value(botsRoleId);
  static Insertable<BotsRoleConfig> custom({
    Expression<int>? guildId,
    Expression<int>? botsRoleId,
  }) {
    return RawValuesInsertable({
      if (guildId != null) 'guild_id': guildId,
      if (botsRoleId != null) 'bots_role_id': botsRoleId,
    });
  }

  BotsRoleConfigsCompanion copyWith(
      {Value<int>? guildId, Value<int>? botsRoleId}) {
    return BotsRoleConfigsCompanion(
      guildId: guildId ?? this.guildId,
      botsRoleId: botsRoleId ?? this.botsRoleId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (guildId.present) {
      map['guild_id'] = Variable<int>(guildId.value);
    }
    if (botsRoleId.present) {
      map['bots_role_id'] = Variable<int>(botsRoleId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BotsRoleConfigsCompanion(')
          ..write('guildId: $guildId, ')
          ..write('botsRoleId: $botsRoleId')
          ..write(')'))
        .toString();
  }
}

abstract class _$SwanDatabase extends GeneratedDatabase {
  _$SwanDatabase(QueryExecutor e) : super(e);
  $SwanDatabaseManager get managers => $SwanDatabaseManager(this);
  late final $AntiSpamConfigsTable antiSpamConfigs =
      $AntiSpamConfigsTable(this);
  late final $BotsRoleConfigsTable botsRoleConfigs =
      $BotsRoleConfigsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [antiSpamConfigs, botsRoleConfigs];
}

typedef $$AntiSpamConfigsTableCreateCompanionBuilder = AntiSpamConfigsCompanion
    Function({
  Value<int> guildId,
  required int warningChannelId,
  required int rulesChannelId,
});
typedef $$AntiSpamConfigsTableUpdateCompanionBuilder = AntiSpamConfigsCompanion
    Function({
  Value<int> guildId,
  Value<int> warningChannelId,
  Value<int> rulesChannelId,
});

class $$AntiSpamConfigsTableFilterComposer
    extends Composer<_$SwanDatabase, $AntiSpamConfigsTable> {
  $$AntiSpamConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get guildId => $composableBuilder(
      column: $table.guildId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get warningChannelId => $composableBuilder(
      column: $table.warningChannelId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rulesChannelId => $composableBuilder(
      column: $table.rulesChannelId,
      builder: (column) => ColumnFilters(column));
}

class $$AntiSpamConfigsTableOrderingComposer
    extends Composer<_$SwanDatabase, $AntiSpamConfigsTable> {
  $$AntiSpamConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get guildId => $composableBuilder(
      column: $table.guildId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get warningChannelId => $composableBuilder(
      column: $table.warningChannelId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rulesChannelId => $composableBuilder(
      column: $table.rulesChannelId,
      builder: (column) => ColumnOrderings(column));
}

class $$AntiSpamConfigsTableAnnotationComposer
    extends Composer<_$SwanDatabase, $AntiSpamConfigsTable> {
  $$AntiSpamConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get guildId =>
      $composableBuilder(column: $table.guildId, builder: (column) => column);

  GeneratedColumn<int> get warningChannelId => $composableBuilder(
      column: $table.warningChannelId, builder: (column) => column);

  GeneratedColumn<int> get rulesChannelId => $composableBuilder(
      column: $table.rulesChannelId, builder: (column) => column);
}

class $$AntiSpamConfigsTableTableManager extends RootTableManager<
    _$SwanDatabase,
    $AntiSpamConfigsTable,
    AntiSpamConfig,
    $$AntiSpamConfigsTableFilterComposer,
    $$AntiSpamConfigsTableOrderingComposer,
    $$AntiSpamConfigsTableAnnotationComposer,
    $$AntiSpamConfigsTableCreateCompanionBuilder,
    $$AntiSpamConfigsTableUpdateCompanionBuilder,
    (
      AntiSpamConfig,
      BaseReferences<_$SwanDatabase, $AntiSpamConfigsTable, AntiSpamConfig>
    ),
    AntiSpamConfig,
    PrefetchHooks Function()> {
  $$AntiSpamConfigsTableTableManager(
      _$SwanDatabase db, $AntiSpamConfigsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AntiSpamConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AntiSpamConfigsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AntiSpamConfigsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> guildId = const Value.absent(),
            Value<int> warningChannelId = const Value.absent(),
            Value<int> rulesChannelId = const Value.absent(),
          }) =>
              AntiSpamConfigsCompanion(
            guildId: guildId,
            warningChannelId: warningChannelId,
            rulesChannelId: rulesChannelId,
          ),
          createCompanionCallback: ({
            Value<int> guildId = const Value.absent(),
            required int warningChannelId,
            required int rulesChannelId,
          }) =>
              AntiSpamConfigsCompanion.insert(
            guildId: guildId,
            warningChannelId: warningChannelId,
            rulesChannelId: rulesChannelId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AntiSpamConfigsTableProcessedTableManager = ProcessedTableManager<
    _$SwanDatabase,
    $AntiSpamConfigsTable,
    AntiSpamConfig,
    $$AntiSpamConfigsTableFilterComposer,
    $$AntiSpamConfigsTableOrderingComposer,
    $$AntiSpamConfigsTableAnnotationComposer,
    $$AntiSpamConfigsTableCreateCompanionBuilder,
    $$AntiSpamConfigsTableUpdateCompanionBuilder,
    (
      AntiSpamConfig,
      BaseReferences<_$SwanDatabase, $AntiSpamConfigsTable, AntiSpamConfig>
    ),
    AntiSpamConfig,
    PrefetchHooks Function()>;
typedef $$BotsRoleConfigsTableCreateCompanionBuilder = BotsRoleConfigsCompanion
    Function({
  Value<int> guildId,
  required int botsRoleId,
});
typedef $$BotsRoleConfigsTableUpdateCompanionBuilder = BotsRoleConfigsCompanion
    Function({
  Value<int> guildId,
  Value<int> botsRoleId,
});

class $$BotsRoleConfigsTableFilterComposer
    extends Composer<_$SwanDatabase, $BotsRoleConfigsTable> {
  $$BotsRoleConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get guildId => $composableBuilder(
      column: $table.guildId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get botsRoleId => $composableBuilder(
      column: $table.botsRoleId, builder: (column) => ColumnFilters(column));
}

class $$BotsRoleConfigsTableOrderingComposer
    extends Composer<_$SwanDatabase, $BotsRoleConfigsTable> {
  $$BotsRoleConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get guildId => $composableBuilder(
      column: $table.guildId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get botsRoleId => $composableBuilder(
      column: $table.botsRoleId, builder: (column) => ColumnOrderings(column));
}

class $$BotsRoleConfigsTableAnnotationComposer
    extends Composer<_$SwanDatabase, $BotsRoleConfigsTable> {
  $$BotsRoleConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get guildId =>
      $composableBuilder(column: $table.guildId, builder: (column) => column);

  GeneratedColumn<int> get botsRoleId => $composableBuilder(
      column: $table.botsRoleId, builder: (column) => column);
}

class $$BotsRoleConfigsTableTableManager extends RootTableManager<
    _$SwanDatabase,
    $BotsRoleConfigsTable,
    BotsRoleConfig,
    $$BotsRoleConfigsTableFilterComposer,
    $$BotsRoleConfigsTableOrderingComposer,
    $$BotsRoleConfigsTableAnnotationComposer,
    $$BotsRoleConfigsTableCreateCompanionBuilder,
    $$BotsRoleConfigsTableUpdateCompanionBuilder,
    (
      BotsRoleConfig,
      BaseReferences<_$SwanDatabase, $BotsRoleConfigsTable, BotsRoleConfig>
    ),
    BotsRoleConfig,
    PrefetchHooks Function()> {
  $$BotsRoleConfigsTableTableManager(
      _$SwanDatabase db, $BotsRoleConfigsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BotsRoleConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BotsRoleConfigsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BotsRoleConfigsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> guildId = const Value.absent(),
            Value<int> botsRoleId = const Value.absent(),
          }) =>
              BotsRoleConfigsCompanion(
            guildId: guildId,
            botsRoleId: botsRoleId,
          ),
          createCompanionCallback: ({
            Value<int> guildId = const Value.absent(),
            required int botsRoleId,
          }) =>
              BotsRoleConfigsCompanion.insert(
            guildId: guildId,
            botsRoleId: botsRoleId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BotsRoleConfigsTableProcessedTableManager = ProcessedTableManager<
    _$SwanDatabase,
    $BotsRoleConfigsTable,
    BotsRoleConfig,
    $$BotsRoleConfigsTableFilterComposer,
    $$BotsRoleConfigsTableOrderingComposer,
    $$BotsRoleConfigsTableAnnotationComposer,
    $$BotsRoleConfigsTableCreateCompanionBuilder,
    $$BotsRoleConfigsTableUpdateCompanionBuilder,
    (
      BotsRoleConfig,
      BaseReferences<_$SwanDatabase, $BotsRoleConfigsTable, BotsRoleConfig>
    ),
    BotsRoleConfig,
    PrefetchHooks Function()>;

class $SwanDatabaseManager {
  final _$SwanDatabase _db;
  $SwanDatabaseManager(this._db);
  $$AntiSpamConfigsTableTableManager get antiSpamConfigs =>
      $$AntiSpamConfigsTableTableManager(_db, _db.antiSpamConfigs);
  $$BotsRoleConfigsTableTableManager get botsRoleConfigs =>
      $$BotsRoleConfigsTableTableManager(_db, _db.botsRoleConfigs);
}

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'database.g.dart';

@DriftDatabase(tables: [AntiSpamConfigs, AntiSiegeConfigs])
class SwanDatabase extends _$SwanDatabase {
  SwanDatabase()
      : super(
          NativeDatabase.createInBackground(File('config/database.sqlite3')),
        );

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from == 1) {
            await migrator.createTable(antiSiegeConfigs);
          }
        },
      );

  Stream<AntiSpamConfig?> antiSpamConfig(int id) =>
      (select(antiSpamConfigs)..where((tbl) => tbl.guildId.equals(id)))
          .watchSingleOrNull();

  Future<void> setAntiSpamConfig(AntiSpamConfigsCompanion config) =>
      into(antiSpamConfigs).insertOnConflictUpdate(config);

  Future<void> deleteAntiSpamConfig(int id) =>
      (delete(antiSpamConfigs)..where((tbl) => tbl.guildId.equals(id))).go();

  Stream<AntiSiegeConfig?> antiSiegeConfig(int id) =>
      (select(antiSiegeConfigs)..where((tbl) => tbl.guildId.equals(id)))
          .watchSingleOrNull();

  Future<void> setAntiSiegeConfig(AntiSiegeConfigsCompanion config) =>
      into(antiSiegeConfigs).insertOnConflictUpdate(config);

  Future<void> deleteAntiSiegeConfig(int id) =>
      (delete(antiSiegeConfigs)..where((tbl) => tbl.guildId.equals(id))).go();
}

class AntiSpamConfigs extends Table {
  @override
  Set<Column> get primaryKey => {guildId};

  IntColumn get guildId => integer()();
  IntColumn get warningChannelId => integer()();
  IntColumn get rulesChannelId => integer()();
}

class AntiSiegeConfigs extends Table {
  @override
  Set<Column> get primaryKey => {guildId};

  IntColumn get guildId => integer()();
  IntColumn get logChannelId => integer()();
}

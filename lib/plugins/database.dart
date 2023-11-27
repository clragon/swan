import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'database.g.dart';

final database = SwanDatabase();

@DriftDatabase(tables: [AntiSpamConfig])
class SwanDatabase extends _$SwanDatabase {
  SwanDatabase()
      : super(
          NativeDatabase.createInBackground(File('database.sqlite3')),
        );

  @override
  int get schemaVersion => 1;
}

class AntiSpamConfig extends Table {
  @override
  Set<Column> get primaryKey => {guildId};

  IntColumn get guildId => integer()();
  IntColumn get warningChannelId => integer()();
  IntColumn get rulesChannelId => integer()();
}

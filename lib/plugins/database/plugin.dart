import 'package:swan/plugins/base/plugin.dart';
import 'package:swan/plugins/database/database.dart';

class DatabasePlugin extends BotPlugin {
  DatabasePlugin(this.database);

  final SwanDatabase database;

  @override
  String get name => 'Database';
}

extension DatabasePluginAccess on NyxxGateway {
  SwanDatabase get db {
    SwanDatabase? db =
        options.plugins.whereType<DatabasePlugin>().firstOrNull?.database;
    if (db == null) {
      throw StateError(
          'Tried to access Database, but no DatabasePlugin found.');
    }
    return db;
  }
}

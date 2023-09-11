import 'package:dotenv/dotenv.dart';
import 'package:meta/meta.dart';
import 'package:nyxx/nyxx.dart';
import 'package:swan/plugin.dart';

@immutable
class Environment {
  const Environment({
    required this.token,
  });

  factory Environment.load() {
    DotEnv env = DotEnv()..load();
    for (final param in _params) {
      if (!env.isDefined(param)) {
        throw EnvironmentException(param);
      }
    }

    return Environment(
      token: env[_params[0]]!,
    );
  }

  static const List<String> _params = [
    'DISCORD_BOT_TOKEN',
  ];

  final String token;
}

class EnvironmentException implements Exception {
  EnvironmentException(this.param);

  final String param;

  @override
  String toString() => 'Missing environment variable: $param';
}

class EnvPlugin extends BotPlugin {
  EnvPlugin(this.env);

  @override
  String get name => 'EnvPlugin';

  final Environment env;
}

extension EnvironmentPluginAccess on NyxxGateway {
  Environment get env => options.plugins.whereType<EnvPlugin>().first.env;
}

import 'package:dotenv/dotenv.dart';
import 'package:meta/meta.dart';
import 'package:swan/plugins/base/plugin.dart';

@immutable
class Environment {
  const Environment({
    required this.commandPrefix,
    required this.discordToken,
    this.stackExchangeKey,
  });

  factory Environment.load() {
    DotEnv env = DotEnv(includePlatformEnvironment: true)..load();
    List<String> required = _params.keys.where((key) => _params[key]!).toList();
    for (final param in required) {
      if (!env.isDefined(param)) {
        throw EnvironmentException(param);
      }
    }
    List<String> params = _params.keys.toList();
    return Environment(
      commandPrefix: env[params[0]] ?? '.',
      discordToken: env[params[1]]!,
      stackExchangeKey: env[params[2]],
    );
  }

  /// Map of environment variables to their required status.
  static const Map<String, bool> _params = {
    'COMMAND_PREFIX': false,
    'DISCORD_BOT_TOKEN': true,
    'STACK_EXCHANGE_KEY': false,
  };

  final String commandPrefix;
  final String discordToken;
  final String? stackExchangeKey;
}

class EnvironmentException implements Exception {
  EnvironmentException(this.param);

  final String param;

  @override
  String toString() => 'Missing environment variable: $param';
}

class EnvironmentPlugin extends BotPlugin {
  EnvironmentPlugin(this.env);

  @override
  String get name => 'EnvPlugin';

  final Environment env;
}

extension EnvironmentPluginAccess on NyxxGateway {
  Environment get env {
    Environment? env =
        options.plugins.whereType<EnvironmentPlugin>().firstOrNull?.env;
    if (env == null) {
      throw StateError('Tried to access Environment, but no EnvPlugin found.');
    }
    return env;
  }
}

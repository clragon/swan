import 'package:dotenv/dotenv.dart';
import 'package:meta/meta.dart';
import 'package:swan/plugins/base/plugin.dart';

@immutable
class Environment {
  const Environment({
    required this.commandPrefix,
    required this.discordToken,
    this.stackExchangeApiKey,
    this.pastebinApiKey,
    this.disableDartdocs,
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
    String? prefix = env[params[0]];
    if (prefix == null || prefix.isEmpty) {
      prefix = '.';
    }
    String disableDartdocs = env[params[4]] ?? 'false';
    return Environment(
      commandPrefix: prefix,
      discordToken: env[params[1]]!,
      stackExchangeApiKey: env[params[2]],
      pastebinApiKey: env[params[3]],
      disableDartdocs: bool.parse(disableDartdocs),
    );
  }

  /// Map of environment variables to their required status.
  static const Map<String, bool> _params = {
    'COMMAND_PREFIX': false,
    'DISCORD_BOT_TOKEN': true,
    'STACKEXCHANGE_API_KEY': false,
    'PASTEBIN_API_KEY': false,
    'DISABLE_DARTDOCS': false,
  };

  final String commandPrefix;
  final String discordToken;
  final String? stackExchangeApiKey;
  final String? pastebinApiKey;
  final bool? disableDartdocs;
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
  String get name => 'Environment';

  @override
  String? buildHelpText(NyxxGateway client) =>
      '\n- Command prefix: `${client.env.commandPrefix}`'
      '\n- Stack Exchange Api: `${client.env.stackExchangeApiKey != null ? 'available' : 'limited'}`'
      '\n- Pastebin Api: `${client.env.pastebinApiKey != null ? 'available' : 'unavailable'}`'
      '\n- Dartdoc search: `${(client.env.disableDartdocs ?? false) ? 'disabled' : 'enabled'}`';

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

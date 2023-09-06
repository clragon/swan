import 'package:dotenv/dotenv.dart';
import 'package:meta/meta.dart';

@immutable
class Environment {
  Environment({
    required this.token,
  });

  static const List<String> _params = [
    'TOKEN',
  ];

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

  final String token;
}

class EnvironmentException implements Exception {
  EnvironmentException(this.param);

  final String param;

  @override
  String toString() => 'Missing environment variable: $param';
}

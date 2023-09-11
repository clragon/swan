import 'package:nyxx/nyxx.dart';
import 'package:swan/delete.dart';
import 'package:swan/env.dart';
import 'package:swan/help.dart';
import 'package:swan/swa.dart';

Future<void> main() async {
  Environment env = Environment.load();

  await Nyxx.connectGatewayWithOptions(
    GatewayApiOptions(
      token: env.token,
      intents: GatewayIntents.allUnprivileged | GatewayIntents.messageContent,
      initialPresence: PresenceBuilder(
        status: CurrentUserStatus.online,
        activities: [
          ActivityBuilder(
            name: 'Generating code | .swan',
            type: ActivityType.game,
          )
        ],
        isAfk: false,
      ),
    ),
    GatewayClientOptions(
      plugins: [
        Logging(),
        CliIntegration(),
        IgnoreExceptions(),
        EnvPlugin(env),
        HelpPlugin(),
        CompileSwa(),
        DeleteByReaction(),
      ],
    ),
  );
}

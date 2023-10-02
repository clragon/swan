import 'package:nyxx/nyxx.dart';
import 'package:swan/plugins/env/env.dart';
import 'package:swan/plugins/help/help.dart';
import 'package:swan/plugins/skull/delete.dart';
import 'package:swan/plugins/stackoverflow/plugin.dart';
import 'package:swan/plugins/swa/swa.dart';

Future<void> main() async {
  Environment env = Environment.load();
  await Nyxx.connectGatewayWithOptions(
    GatewayApiOptions(
      token: env.discordToken,
      intents: GatewayIntents.allUnprivileged | GatewayIntents.messageContent,
    ),
    GatewayClientOptions(
      plugins: [
        Logging(),
        CliIntegration(),
        IgnoreExceptions(),
        EnvPlugin(env),
        HelpPlugin(),
        DeleteByReaction(),
        CompileSwa(),
        StackOverflowMirror(),
      ],
    ),
  );
}

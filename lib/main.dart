import 'package:nyxx/nyxx.dart';
import 'package:swan/plugins/anti_spam/plugin.dart';
import 'package:swan/plugins/dartdoc/plugin.dart';
import 'package:swan/plugins/database/database.dart';
import 'package:swan/plugins/database/plugin.dart';
import 'package:swan/plugins/env/plugin.dart';
import 'package:swan/plugins/help/plugin.dart';
import 'package:swan/plugins/paste/plugin.dart';
import 'package:swan/plugins/skull/plugin.dart';
import 'package:swan/plugins/stackoverflow/plugin.dart';
import 'package:swan/plugins/swa/plugin.dart';

Future<void> main() async {
  Environment env = Environment.load();
  SwanDatabase database = SwanDatabase();
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
        EnvironmentPlugin(env),
        DatabasePlugin(database),
        HelpPlugin(),
        DeleteByReaction(),
        CompileSwa(),
        StackOverflowMirror(),
        PasteFiles(),
        DartdocSearch(),
        AntiSpam(),
      ],
    ),
  );
}

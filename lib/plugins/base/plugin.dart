import 'package:nyxx/nyxx.dart';
export 'package:nyxx/nyxx.dart' show NyxxGateway;

abstract class BotPlugin extends NyxxPlugin<NyxxGateway> {
  late final Logger logger = Logger(name);

  String? helpText;

  String? buildHelpText(NyxxGateway client) => helpText;

  bool isEnabled(NyxxGateway client) => true;
}

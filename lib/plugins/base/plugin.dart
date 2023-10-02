import 'package:nyxx/nyxx.dart';
export 'package:nyxx/nyxx.dart' show NyxxGateway;

abstract class BotPlugin extends NyxxPlugin<NyxxGateway> {
  String? helpText;
}

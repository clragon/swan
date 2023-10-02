import 'dart:async';

import 'package:nyxx/nyxx.dart';

abstract class BotPlugin extends NyxxPlugin {
  String? helpText;

  @override
  FutureOr<void> afterConnect(covariant NyxxGateway client) {}

  @override
  FutureOr<void> beforeClose(covariant NyxxGateway client) {}
}

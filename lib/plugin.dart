import 'dart:async';

import 'package:meta/meta.dart';
import 'package:nyxx/nyxx.dart';

abstract class NyxxPlugin2 extends NyxxPlugin {
  /// Called when the plugin is initialized.
  FutureOr<void> onInit() {}

  /// Called when the client is ready.
  FutureOr<void> onReady(Nyxx client) {}

  /// Called when the client is shutting down.
  FutureOr<void> onClose(Nyxx client) {}

  /// Called when the client was closed.
  FutureOr<void> onDispose() {}

  @override
  @nonVirtual
  Future<ClientType> connect<ClientType extends Nyxx>(
    ApiOptions apiOptions,
    ClientOptions clientOptions,
    Future<ClientType> Function() connect,
  ) async {
    await onInit();
    final client = await connect();
    await onReady(client);
    return client;
  }

  @override
  @nonVirtual
  Future<void> close(Nyxx client, Future<void> Function() close) async {
    await onClose(client);
    await close();
    await onDispose();
  }
}

abstract class BotPlugin extends NyxxPlugin2 {
  String? helpText;

  @override
  FutureOr<void> onReady(covariant NyxxGateway client) {}

  @override
  FutureOr<void> onClose(covariant NyxxGateway client) {}
}

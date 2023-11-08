import 'package:nyxx/nyxx.dart';

const kMaxMessageLength = 2000;

/// Builds the error message for when an unhandled exception occurs.
String errorMessage(Object? exception, StackTrace? stackTrace) {
  return 'Something went wrong :(\n'
      'Please contact an administator. '
      'Your error id is: `#${Object().hashCode.toRadixString(16)}`';
}

/// Builds the message link for an event.
String messageLink(MessageCreateEvent event) {
  final message = event.message;

  return 'https://discord.com/channels/'
      '${event.guildId ?? '@me'}/'
      '${message.channel.id}/'
      '${message.id}';
}

extension EventMessageLink on MessageCreateEvent {
  /// Builds the message link for an event.
  String get link => messageLink(this);
}

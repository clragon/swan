import 'package:nyxx/nyxx.dart';

const kMaxMessageLength = 2000;

/// Builds the error message for when an unhandled exception occurs.
String errorMessage(Object? exception, StackTrace? stackTrace) {
  return 'Something went wrong. :(\n'
      'Please contact an administator. '
      'Your error id is: `#${exception.hashCode}`';
}

/// Builds the message link for an event.
String messageLink(Message message) {
  String guildId = '@me';
  if (message.channel is GuildTextChannel) {
    guildId = (message.channel as GuildTextChannel).guildId.toString();
  }
  return 'https://discord.com/channels/'
      '$guildId/'
      '${message.channel.id}/'
      '${message.id}';
}

extension EventMessageLink on MessageCreateEvent {
  /// Builds the message link for an event.
  String get link => messageLink(message);
}

import 'dart:math';

import 'package:nyxx/nyxx.dart';
import 'package:petitparser/petitparser.dart';

/// Builds the help message for the bot.
String helpMessage() {
  return 'Simple Widget Annotation Naturalizer\n\n'
      'To quickly build a Widget tree from SWA, type `.swan >` '
      'followed by your SWA code.\n\n'
      'Example:\n'
      '```\n'
      '.swan > Column > [ Center > Icon(Icons.help), Text(\'Hello, world!\') ]'
      '```\n';
}

/// Builds the error message for when an unhandled exception occurs.
String errorMessage(Object? exception, StackTrace? stackTrace) {
  return 'Something went terribly wrong. '
      'Please contact an administator. '
      'Your error id is: `#${exception.hashCode}`';
}

/// Builds the error message for when a parsing error occurs.
String failureToMessage(String content, Failure failure) {
  var [line, char] = Token.lineAndColumnOf(
    failure.buffer,
    failure.position,
  );
  line = max(0, line - 1);
  List<String> lines = content.split('\n');
  lines.insert(
    line,
    '${' '.padRight(char)}v [$line,$char]: ${failure.message}',
  );
  return lines.join('\n');
}

/// Builds the message link for an event.
String messageLink(IMessageReceivedEvent event) {
  return 'https://discord.com/channels/'
      '${event.message.guild?.id ?? '@me'}/'
      '${event.message.channel.id}/'
      '${event.message.id}';
}

extension EventMessageLink on IMessageReceivedEvent {
  /// Builds the message link for an event.
  String get link => messageLink(this);
}

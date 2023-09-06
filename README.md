# SWAN

The Swan bot helps converting SWA to Dart code.

## Syntax

Simple Widget Annotation (SWA) is a text-based syntax that allows you to describe Flutter widget trees in a concise manner.

### Example

```plaintext
Column > [ Center > Icon(Icons.help), Text('Hello, world!') ]
```

The above SWA code will generate the following Dart code:

```dart
Column(
  children: [
    Center(
      child: Icon(Icons.help),
    ),
    Text('Hello, world!'),
  ],
);
```

SWA syntax is flexible.
You may omit or add as many spaces or newlines as you like.
You may also omit the `>` character before a list of children.

## Usage

To trigger a code generation from the bot,

- begin your message with `.swa >` followed by the SWA code.  
  (You may also specify a file name before the dot.)  
  e.g. `.swa > Column [ Text('Hello, world!') ]`  
  or `hello_world.swa > Text('Hello, world!')`
- (_TODO_) add one or multiple code blocks to your message which use `swa` as the language identifier
- (_TODO_) upload one or multiple files with the `.swa` extension

To see the help message, send a message with just `.swa` in it.

To delete the bot's response, react to it with the 💀 emoji.

## Dependencies

- [Nyxx Discord API library](https://pub.dev/packages/nyxx)
- [PetitParser for grammar and parsing](https://pub.dev/packages/petitparser)
- [Dart Style for code formatting](https://pub.dev/packages/dart_style)

## Setup

To run the bot, you need to provide it with a Discord bot token.  
You can get one by creating a new application on the [Discord Developer Portal](https://discord.com/developers/applications).

Once you have a token, create a file named `.env` in the root directory of the project and add the following line to it:

```plaintext
TOKEN=your_token_here
```

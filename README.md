# SWAN

<img src="assets/icon.png" width="128" height="128"/>

Swan helps bring elegance to your flutter discussions.

## Plugins

### Simple Widget Annotation

Quickly generate Flutter widget trees from a simple text-based syntax.

#### Syntax

Simple Widget Annotation (SWA) is a text-based syntax that allows you to describe Flutter widget trees in a concise manner.

#### Example

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

#### Usage

To trigger a code generation from the bot,

- begin your message with `.swa` followed by the SWA code.  
  e.g. `.swa Column [ Text('Hello, world!') ]`
- add one or multiple code blocks to your message which use `swa` as the language identifier
- upload one or multiple files with the `.swa` extension

A maximum of 5 sources of SWA code will be processed per message.

To see the help message, send a message with just `.swa` in it.

The SWA parser is based on an EBNF grammar.  
The full grammar is available [here](/lib/plugins/swa/grammar.ebnf).  
You can test it on [this website](https://bnfplayground.pauliankline.com/).

### Skull emoji

Delete the bot's response with a skull emoji.

#### Usage

React to a bot response with the 💀 emoji to delete it.
This only works if you are the author of the message that triggered the bot.

### StackOverflow Mirror

Print StackOverflow questions in a Discord channel.  
This feature works better with an API key. See [Setup](#setup).

#### Usage

To trigger a StackOverflow question mirror,

- begin your message with `.flow` followed by a StackOverflow link.
- reply to a message containing a StackOverflow link with `.flow`.

### Pastebin Uploader

Upload files to Pastebin.
This feature requires an API key. See [Setup](#setup).

#### Usage

To upload a file to Pastebin,

- begin your message with `.paste`, and attach a file (or multiple) to it.
- reply to a message containing a file (or multiple) with `.paste`.

## Dependencies

- [Nyxx Discord API library](https://pub.dev/packages/nyxx)
- [PetitParser for grammar and parsing](https://pub.dev/packages/petitparser)
- [Dart Style for code formatting](https://pub.dev/packages/dart_style)

## Setup

To run the bot, you need to provide it with a Discord bot token.  
You can get one by creating a new application on the [Discord Developer Portal](https://discord.com/developers/applications).

Once you have a token, create a file named `.env` in the root directory of the project and add the following line to it:

```yml
DISCORD_BOT_TOKEN=your_token_here
```

For additional plugins, you may need to provide extra API keys:

```yml
STACKEXCHANGE_API_KEY=your_key_here # optional, but recommended
PASTEBIN_API_KEY=your_key_here # required for the pastebin plugin
```

You can also specify a custom prefix for the bot:

```yml
BOT_PREFIX=your_prefix_here # default: .
```

import 'package:petitparser/petitparser.dart';
import 'package:swan/plugins/swa/model.dart';

class SimpleWidgetAnnotationGrammer
    extends GrammarDefinition<SimpleWidgetAnnotation> {
  /// <SWA> ::= <Whitespace> <TokenChain> <Whitespace>
  @override
  Parser<SimpleWidgetAnnotation> start() => [
        (ref0(whitespace) & ref0(tokenChain) & ref0(whitespace)),
        endOfInput()
      ].toSequenceParser().pick(0).cast();

  Parser<SimpleWidgetAnnotation> tokenChain() => <Parser>[
        ref0(token),
        [
          [
            ref0(whitespace),
            char('>'),
            ref0(whitespace),
            ref0(tokenChain),
          ].toSequenceParser().pick(3),
          [
            ref0(whitespace),
            char('>').optional(),
            ref0(whitespace),
            char('['),
            ref0(whitespace),
            ref0(tokenList),
            ref0(whitespace),
            char(']'),
          ].toSequenceParser().pick(6),
        ].toChoiceParser(),
      ].toSequenceParser().map(
            (value) => SimpleWidgetAnnotation(
              name: value[0] as String,
              child: value[1] as SimpleWidgetToken?,
            ),
          );

  Parser<SimpleWidgetChildren> tokenList() => [
        ref0(token),
        [
          ref0(whitespace),
          char(','),
          ref0(whitespace),
          ref0(token),
        ].toSequenceParser().pick(3).star(),
      ].toSequenceParser().map(
            (value) => SimpleWidgetChildren([
              value[0] as SimpleWidgetToken,
              ...value[1] as List<SimpleWidgetToken>,
            ]),
          );

  Parser<SimpleWidgetAnnotation> token() => [
        ref0(identifierChain),
        ref0(functionCall),
      ].toChoiceParser().cast();

  Parser<SimpleWidgetToken> expression() => [
        ref0(stringLiteral),
        ref0(functionCall),
        ref0(ternary),
      ].toChoiceParser().cast();

  /// <FunctionCall> ::= <Identifier> <Whitespace> <Generics>? <Whitespace> "(" <Whitespace> <ParameterList>? <Whitespace> ")"
  Parser<SimpleWidgetToken> functionCall() => [
        ref0(identifierChain),
        ref0(whitespace),
        ref0(generics),
        ref0(whitespace),
        char('('),
        ref0(whitespace),
        ref0(parameterList),
        ref0(whitespace),
        char(')'),
      ].toSequenceParser().map((value) => value).cast();

  /// <Generics> ::= "<" <Whitespace> <TypeList> <Whitespace> ">"
  Parser<String> generics() => [
        char('<'),
        ref0(typeList),
        char('>'),
      ].toSequenceParser().flatten();

  /// <TypeList> ::= <Identifier> <Whitespace> "," <Whitespace> <TypeList> | <Identifier>
  Parser<String> typeList() =>
      (ref0(whitespace) & ref0(identifier) & ref0(whitespace))
          .plusSeparated(char(','))
          .flatten();

  /// <ParameterList> ::= <Parameter> <Whitespace> "," <Whitespace> <ParameterList> | <Parameter>
  Parser<List<SimpleWidgetToken>> parameterList() => [
        ref0(whitespace),
        ref0(parameter),
        [
          ref0(whitespace),
          char(','),
          ref0(whitespace),
          ref0(parameter),
        ].toSequenceParser().pick(3).star(),
      ].toSequenceParser().map(
            (value) => [
              value[0] as SimpleWidgetToken,
              ...value[1] as List<SimpleWidgetToken>,
            ],
          );

  /// <Parameter> ::= <NamedParam> | <Token> | <Expression>
  Parser<SimpleWidgetToken> parameter() => [
        ref0(namedParameter),
        ref0(token),
        ref0(expression),
      ].toChoiceParser().cast();

  /// <NamedParameter> ::= <Identifier> <Whitespace> ":" <Whitespace> <Parameter>
  Parser<SimpleWidgetToken> namedParameter() => <Parser>[
        [
          ref0(identifier),
          ref0(whitespace),
          // optional, so we can also parse typed parameters
          char(':').optional(),
          ref0(whitespace),
        ].toSequenceParser(),
        [
          ref0(token),
          ref0(expression),
        ].toChoiceParser(),
      ]
          .toSequenceParser()
          .map(
            (value) => SimpleWidgetElement(value[0], value[1]),
          )
          .cast();

  Parser<SimpleWidgetTernary> ternary() => [
        [
          ref0(expression),
          ref0(whitespace),
        ].toSequenceParser(),
        [
          char('?'),
          ref0(whitespace),
          ref0(expression),
          ref0(whitespace),
        ].toSequenceParser(),
        [
          char(':'),
          ref0(whitespace),
          ref0(expression),
        ].toSequenceParser(),
      ].toSequenceParser().map(
            (value) => SimpleWidgetTernary(
              value[0] as SimpleWidgetToken,
              value[1] as SimpleWidgetToken,
              value[2] as SimpleWidgetToken,
            ),
          );

  Parser<SimpleWidgetElement> anonymousFunction() => [
        [
          char('('),
          ref0(whitespace),
          ref0(parameterList),
          ref0(whitespace),
          char(')'),
          ref0(whitespace),
        ].toSequenceParser().flatten(),
        [
          char('=>'),
          ref0(whitespace),
          ref0(tokenChain),
          ref0(whitespace),
        ].toSequenceParser().pick(2),
      ].toSequenceParser().map(
            (value) => SimpleWidgetElement(
              value[0] as String,
              value[1] as SimpleWidgetToken,
            ),
          );

  Parser<SimpleWidgetToken> array() => [
        [
          char('['),
          ref0(whitespace),
          ref0(expression),
        ].toSequenceParser().pick(2),
        [
          ref0(whitespace),
          char(','),
          ref0(whitespace),
          ref0(expression),
        ].toSequenceParser().pick(3).star(),
        [
          ref0(whitespace),
          char(']'),
        ].toSequenceParser(),
      ].toSequenceParser().map(
            (value) => SimpleWidgetChildren([
              value[0] as SimpleWidgetToken,
              ...value[1] as List<SimpleWidgetToken>,
            ]),
          );

  Parser<SimpleWidgetLiteral> stringLiteral() => [
        (char('"') & any().starLazy(char('"')) & char('"')).pick(1),
        (char("'") & any().starLazy(char("'")) & char("'")).pick(1),
      ].toChoiceParser().flatten().map((value) => SimpleWidgetLiteral(value));

  /// <IdentifierChain> ::= <Identifier> <Whitespace> "." <Whitespace> <IdentifierChain> | <Identifier>
  Parser<String> identifierChain() => [
        ref0(identifier),
        [
          ref0(whitespace),
          char('.'),
          ref0(whitespace),
          ref0(identifierChain),
        ].toSequenceParser().star(),
      ].toSequenceParser().flatten();

  /// <Identifier> ::= <AlphaNumChar>+
  Parser<String> identifier() => ref0(alphaNumeric).plus().flatten();

  /// <AlphaNumChar> ::= [a-z] | [A-Z] | [0-9]
  Parser<String> alphaNumeric() => (letter() | digit()).plus().flatten();

  /// <Whitespace> ::= (" " | "\n")*
  Parser<String> whitespace() => (char(' ') | char('\n')).star().flatten();
}

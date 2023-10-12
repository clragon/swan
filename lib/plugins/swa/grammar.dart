import 'package:petitparser/petitparser.dart';
import 'package:swan/plugins/swa/model.dart';

class SimpleWidgetAnnotationGrammer
    extends GrammarDefinition<SimpleWidgetAnnotation> {
  /// <SWA> ::= <Whitespace> <TokenChain> <Whitespace>
  @override
  Parser<SimpleWidgetAnnotation> start() => [
        [
          ref0(space),
          ref0(token),
          ref0(space),
        ].toSequenceParser().pick(1),
        endOfInput()
      ].toSequenceParser().pick(0).cast();

  Parser<SimpleWidgetAnnotation> token() => <Parser>[
        [
          ref0(functionCall),
          ref0(identifierChain).map((value) => (value, null)),
        ].toChoiceParser(),
        [
          [
            char('>').spaced(),
            ref0(token),
          ].toSequenceParser().pick(1),
          [
            char('>').spaced().optional(),
            char('[').spaced(),
            ref0(tokenList).optional(),
            char(']').spaced(),
          ].toSequenceParser().pick(2),
        ].toChoiceParser().optional(),
      ].toSequenceParser().map(
            (value) => SimpleWidgetAnnotation(
              name: (value[0] as TokenHead).$1,
              parameters: (value[0] as TokenHead).$2,
              child: value[1] as SimpleWidgetToken?,
            ),
          );

  Parser<SimpleWidgetChildren> tokenList() => [
        ref0(token),
        [
          char(',').spaced(),
          ref0(token),
        ].toSequenceParser().pick(1).star().castList<SimpleWidgetAnnotation>(),
        char(',').spaced().optional(),
      ].toSequenceParser().map(
            (value) => SimpleWidgetChildren([
              value[0] as SimpleWidgetToken,
              ...value[1] as List<SimpleWidgetToken>,
            ]),
          );

  /// <FunctionCall> ::= <Identifier> <Whitespace> <Generics>? <Whitespace> "(" <Whitespace> <ParameterList>? <Whitespace> ")"
  Parser<TokenHead> functionCall() {
    return [
      [
        ref0(identifierChain),
        ref0(space),
        ref0(generics).optional(),
      ].toSequenceParser().flatten(),
      [
        char('(').spaced(),
        ref0(parameterList),
        char(')').spaced(),
      ].toSequenceParser().pick(1),
    ].toSequenceParser().map(
          (value) => (
            value[0] as String,
            value[1] as List<SimpleWidgetToken>,
          ),
        );
  }

  /// <Generics> ::= "<" <Whitespace> <TypeList> <Whitespace> ">"
  Parser<String> generics() => [
        char('<'),
        ref0(typeList),
        char('>'),
      ].toSequenceParser().flatten();

  /// <TypeList> ::= <Identifier> <Whitespace> "," <Whitespace> <TypeList> | <Identifier>
  Parser<String> typeList() => [
        ref0(space),
        ref0(identifier),
        ref0(space),
      ].toSequenceParser().plusSeparated(char(',')).flatten();

  /// <ParameterList> ::= <Parameter> <Whitespace> "," <Whitespace> <ParameterList> | <Parameter>
  Parser<List<SimpleWidgetToken>> parameterList() => [
        ref0(parameter).starSeparated(char(',')).map((value) => value.elements),
        char(',').spaced().optional(),
      ].toSequenceParser().pick(0).castList<SimpleWidgetToken>();

  Parser<SimpleWidgetToken> value() => [
        ref0(expression),
        ref0(token),
      ].toChoiceParser().cast();

  /// <Parameter> ::= <NamedParam> | <Token> | <Expression>
  Parser<SimpleWidgetToken> parameter() => [
        ref0(namedParameter),
        ref0(value),
      ].toChoiceParser().cast();

  /// <NamedParameter> ::= <Identifier> <Whitespace> ":" <Whitespace> <Parameter>
  Parser<SimpleWidgetToken> namedParameter() => <Parser>[
        [
          ref0(identifier),
          // optional, so we can also parse typed parameters
          char(':').spaced().optional(),
        ].toSequenceParser().flatten(),
        [
          ref0(value),
        ].toChoiceParser(),
      ].toSequenceParser().map(
            (value) => SimpleWidgetElement(value[0], value[1]),
          );

  Parser<SimpleWidgetToken> expression() => [
        ref0(identifierChain).map(SimpleWidgetLiteral.new),
        ref0(stringLiteral),
        ref0(ternary),
        // ref0(anonymousFunction),
      ].toChoiceParser().cast();

  Parser<SimpleWidgetTernary> ternary() => [
        ref0(expression),
        [
          char('?').spaced(),
          ref0(value),
        ].toSequenceParser().pick(1),
        [
          char(':').spaced(),
          ref0(value),
        ].toSequenceParser().pick(1),
      ].toSequenceParser().map(
            (value) => SimpleWidgetTernary(
              value[0] as SimpleWidgetToken,
              value[1] as SimpleWidgetToken,
              value[2] as SimpleWidgetToken,
            ),
          );

  Parser<SimpleWidgetElement> anonymousFunction() => [
        [
          char('(').spaced(),
          ref0(parameterList),
          char(')').spaced(),
          string('=>').spaced(),
        ].toSequenceParser().flatten(),
        ref0(value),
      ].toSequenceParser().map(
            (value) => SimpleWidgetElement(
              value[0] as String,
              value[1] as SimpleWidgetToken,
            ),
          );

  Parser<SimpleWidgetToken> array() => [
        [
          char('[').spaced(),
          ref0(value),
        ].toSequenceParser().pick(1),
        [
          char(',').spaced(),
          ref0(value),
        ].toSequenceParser().pick(1).star(),
        char(']').spaced(),
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
  Parser<String> identifierChain() =>
      ref0(identifier).plusSeparated(char('.')).flatten();

  /// <Identifier> ::= <AlphaNumChar>+
  Parser<String> identifier() => (letter() | digit()).plus().flatten();
}

typedef TokenHead = (String, List<SimpleWidgetToken>?);

Parser<dynamic> space() => [whitespace(), newline()].toChoiceParser().star();

extension Whitespaced on Parser {
  Parser<dynamic> spaced() => <Parser>[
        ref0(space),
        this,
        ref0(space),
      ].toSequenceParser();
}

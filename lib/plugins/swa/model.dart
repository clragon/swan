sealed class SimpleWidgetToken {}

class SimpleWidgetChildren extends SimpleWidgetToken {
  SimpleWidgetChildren(this.value);

  final List<SimpleWidgetToken> value;

  @override
  String toString() => '[${value.join(', ')}]';
}

class SimpleWidgetLiteral extends SimpleWidgetToken {
  SimpleWidgetLiteral(this.value);

  final String value;

  @override
  String toString() => value;
}

class SimpleWidgetElement extends SimpleWidgetToken {
  SimpleWidgetElement(this.name, this.child);

  final String? name;
  final SimpleWidgetToken child;

  @override
  String toString() => '${name ?? ''} $child';
}

class SimpleWidgetTernary extends SimpleWidgetToken {
  SimpleWidgetTernary(this.condition, this.then, this.otherwise);

  final SimpleWidgetToken condition;
  final SimpleWidgetToken then;
  final SimpleWidgetToken otherwise;

  @override
  String toString() => '$condition ? $then : $otherwise';
}

class SimpleWidgetAnnotation extends SimpleWidgetToken {
  SimpleWidgetAnnotation({
    required this.name,
    this.parameters,
    this.child,
  });

  final String name;
  final List<SimpleWidgetToken>? parameters;
  final SimpleWidgetToken? child;

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.write(name);
    if (parameters != null) {
      buffer.write('(');
      buffer.write(parameters!.join(', '));
      buffer.write(')');
    }
    if (child != null) {
      buffer.write(' > ');
      buffer.write(child);
    }
    return buffer.toString();
  }
}

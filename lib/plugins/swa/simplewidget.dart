sealed class SimpleWidgetToken {}

class SimpleWidgetLiteral extends SimpleWidgetToken {
  SimpleWidgetLiteral(this.value);

  final String value;

  @override
  String toString() => value;
}

class SimpleWidgetKey extends SimpleWidgetToken {
  SimpleWidgetKey(this.value);

  final String? value;

  @override
  String toString() => value ?? '';
}

class SimpleWidgetAnnotation extends SimpleWidgetToken {
  SimpleWidgetAnnotation({
    required this.name,
    this.parameters,
    this.children,
  });

  final String name;
  final Map<SimpleWidgetKey, SimpleWidgetToken>? parameters;
  final List<SimpleWidgetAnnotation>? children;

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.write(name);
    if (parameters != null) {
      buffer.write('(');
      buffer.write(
        parameters!.entries
            .map((e) => '${e.key.value != null ? '${e.key.value}: ' : ''}'
                '${e.value}')
            .join(', '),
      );
      buffer.write(')');
    }
    if (children != null) {
      bool multiple = children!.length > 1;
      if (multiple) {
        buffer.write(' > [ ');
      } else {
        buffer.write(' > ');
      }
      buffer.write(children!.join(', '));
      if (multiple) {
        buffer.write(' ]');
      }
    }
    return buffer.toString();
  }
}

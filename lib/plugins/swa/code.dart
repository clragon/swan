import 'package:swan/plugins/swa/model.dart';

class SimpleWidgetCode extends SimpleWidgetAnnotation {
  SimpleWidgetCode({
    required super.name,
    super.parameters,
    super.child,
  });

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.write(name);
    buffer.write('(');
    List<SimpleWidgetToken>? parameters = this.parameters;
    if (child != null) {
      parameters ??= [];
      bool multiple = child is SimpleWidgetChildren;
      SimpleWidgetElement element;
      if (multiple) {
        element = SimpleWidgetElement(
          'children:',
          child!,
        );
      } else {
        element = SimpleWidgetElement(
          'child:',
          child!,
        );
      }
      parameters.add(element);
    }
    if (parameters != null) {
      buffer.write(parameters.map((e) => e.toString()).join(', '));
      buffer.write(', ');
    }
    buffer.write(')');
    return buffer.toString();
  }
}

extension SimpleWidgetCodeConversion on SimpleWidgetToken {
  SimpleWidgetToken toCode() => switch (this) {
        SimpleWidgetAnnotation a => SimpleWidgetCode(
            name: a.name,
            parameters: a.parameters?.map((e) => e.toCode()).toList(),
            child: a.child?.toCode(),
          ),
        SimpleWidgetChildren c =>
          SimpleWidgetChildren(c.value.map((e) => e.toCode()).toList()),
        SimpleWidgetElement e => SimpleWidgetElement(e.name, e.child.toCode()),
        SimpleWidgetTernary t => SimpleWidgetTernary(
            t.condition.toCode(),
            t.then.toCode(),
            t.otherwise.toCode(),
          ),
        _ => this
      };
}

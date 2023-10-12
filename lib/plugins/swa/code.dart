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
    if (parameters != null) {
      buffer.write(parameters!.map((e) => e.toString()).join(', '));
    }
    if (child != null) {
      if (parameters != null) {
        buffer.write(', ');
      }
      bool multiple = child is SimpleWidgetChildren;
      if (multiple) {
        buffer.write('children: ');
      } else {
        buffer.write('child: ');
      }
      buffer.write(child);
      buffer.write(', ');
      if (multiple) {
        buffer.write('],');
      }
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

import 'package:swan/grammar.dart';

class SimpleWidgetCode extends SimpleWidgetAnnotation {
  SimpleWidgetCode({
    required super.name,
    super.parameters,
    super.children,
  });

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.write(name);
    buffer.write('(');
    if (parameters != null) {
      buffer.write(
        parameters!.entries
            .map((e) => '${e.key.value != null ? '${e.key.value}: ' : ''}'
                '${e.value}')
            .join(', '),
      );
    }
    if (children != null) {
      if (parameters != null) {
        buffer.write(', ');
      }
      bool multiple = children!.length > 1;
      if (multiple) {
        buffer.write('children: [');
      } else {
        buffer.write('child: ');
      }
      buffer.write(children!.join(', '));
      buffer.write(', ');
      if (multiple) {
        buffer.write('],');
      }
    }
    buffer.write(')');
    return buffer.toString();
  }
}

extension SimpleWidgetCodeConversion on SimpleWidgetAnnotation {
  SimpleWidgetCode toCode() => SimpleWidgetCode(
        name: name,
        parameters: parameters,
        children: children?.map((e) => e.toCode()).toList(),
      );
}

import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dex_generator/src/model/field.dart';

class ClassVisitor extends SimpleElementVisitor {
  final Element element;
  Set<Field> fields;

  ClassVisitor(this.element);

  @override
  visitConstructorElement(ConstructorElement element) {
    element.declaration.parameters.forEach((e) {
      fields.add(
        Field(
            type: e.type,
            name: e.displayName,
            hasValue: e.hasDefaultValue,
            value: e.defaultValueCode),
      );
    });
    return super.visitConstructorElement(element);
  }
}

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:dex_generator/src/model/field.dart';

class ClassVisitor extends SimpleElementVisitor {
  DartType classType;
  Set<Field> fields = Set();

  @override
  visitConstructorElement(ConstructorElement element) {
    assert(classType == null);
    classType = element.type.returnType;

    element.parameters.forEach((e) {
      fields.add(
        Field(
            type: e.type,
            name: e.displayName,
            hasValue: e.hasDefaultValue,
            value: e.defaultValueCode),
      );
    });
  }

  @override
  String toString() =>'ClassVisitor{fields: $fields}';
}

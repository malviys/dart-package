import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:dex_generator/src/annotation/data.dart';
import 'package:dex_generator/src/model/field.dart';
import 'package:source_gen/source_gen.dart';

class DataClassGenerator extends GeneratorForAnnotation<DataClass> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    return _dataClassSourceGenerate(element);
  }
}

String _dataClassSourceGenerate(Element element) {
  assertDataClass(element);

  final codeBuffer = StringBuffer();
  final visitor = DataClassVisitor();

  element.visitChildren(visitor);

  // declaring class
  codeBuffer.write("class ${element.displayName.replaceFirst("_\$", "")} {");

  // fields
  generateFields(codeBuffer, visitor);

  // constructor
  generateConstructor(codeBuffer, element, visitor);

  // copy with
  generateCopyWith(codeBuffer, element, visitor);

  // from Map
  generateFromMap(codeBuffer, element, visitor);

  // to Map
  generateToMap(codeBuffer, element, visitor);

  // hash code
  generateHashCode(codeBuffer, visitor);

  // equals
  generateEquals(codeBuffer, element, visitor);

  // toString
  generateToString(codeBuffer, element, visitor);

  // end of class
  codeBuffer.writeln("}");

  // comment
  codeBuffer.write("// Generated Successfully");

  return "${codeBuffer.toString()}";
}

class DataClassVisitor extends SimpleElementVisitor {
  Set<Field> constructorFields = {};

  @override
  visitConstructorElement(ConstructorElement element) {
    element.declaration.parameters.forEach((e) {
      constructorFields.add(
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

void assertDataClass(Element element) {
  Element el;

  try {
    el = element as ClassElement;
  } catch (e) {
    throw Exception(
      "${element.displayName} should be a class check your definition at ${element.library}",
    );
  }

  if (!el.isPrivate && !el.displayName.startsWith("_\$")) {
    throw Exception(
      "${el.displayName} should be private and starts with _\$ check your definition at ${el.library}",
    );
  }
}

void generateFields(StringBuffer codeBuffer, DataClassVisitor visitor) {
  visitor.constructorFields.forEach((e) => codeBuffer.writeln(e.field));
}

void generateConstructor(
    StringBuffer codeBuffer, Element element, DataClassVisitor visitor) {
  codeBuffer.write("const ${element.displayName.replaceFirst("_\$", "")}({");
  visitor.constructorFields.forEach(
    (e) => codeBuffer.write("${e.constructorField}"),
  );
  codeBuffer.write("});");
}

void generateCopyWith(
    StringBuffer codeBuffer, Element element, DataClassVisitor visitor) {
  codeBuffer.write("${element.name.replaceFirst("_\$", "")} copyWith({");
  visitor.constructorFields.forEach((e) => codeBuffer
      .write("${e.type.getDisplayString(withNullability: false)} ${e.name},"));
  codeBuffer.write("}){");
  codeBuffer.write("if(");
  var str = "";
  visitor.constructorFields.forEach((e) {
    str += "(${e.name} == null || identical(${e.name}, this.${e.name})) && ";
  });
  codeBuffer.write(str.substring(0, str.lastIndexOf("&&")));
  codeBuffer.write("){");
  codeBuffer.write("return this;");
  codeBuffer.write("}");

  codeBuffer.write("return ${element.displayName.replaceFirst("_\$", "")}(");
  visitor.constructorFields.forEach((e) {
    codeBuffer.write("${e.name}: ${e.name} ?? this.${e.name},");
  });
  codeBuffer.write(");}");
}

void generateFromMap(
  StringBuffer codeBuffer,
  Element element,
  DataClassVisitor visitor,
) {
  codeBuffer.writeln(
      "factory ${element.displayName.replaceFirst("_\$", "")}.fromMap(Map<String, dynamic> map) {");
  codeBuffer.writeln("return new ${element.displayName.replaceFirst("_\$", "")}(");
  visitor.constructorFields.forEach((e) {
    codeBuffer.write(
        "${e.name}: map['${e.name}'] as ${e.type.getDisplayString(withNullability: false)},");
  });
  codeBuffer.writeln(");");
  codeBuffer.writeln("}");
}

void generateToMap(
  StringBuffer codeBuffer,
  Element element,
  DataClassVisitor visitor,
) {
  codeBuffer.writeln("Map<String, dynamic> toMap() {");
  codeBuffer.writeln("return {");
  visitor.constructorFields.forEach((e) {
    codeBuffer.writeln("${e.name} : this.${e.name},");
  });
  codeBuffer.writeln("} as Map<String, dynamic>;");
  codeBuffer.writeln("}");
}

void generateHashCode(StringBuffer codeBuffer, DataClassVisitor visitor) {
  codeBuffer.writeln("@override");
  codeBuffer.writeln("int get hashCode{");
  var str = "return ";
  visitor.constructorFields.forEach((e) {
    str += "${e.name}.hashCode ^ ";
  });
  codeBuffer.write(str.substring(0, str.lastIndexOf("^ ")) + ";");
  codeBuffer.writeln("}");
}

void generateEquals(
    StringBuffer codeBuffer, Element element, DataClassVisitor visitor) {
  codeBuffer.writeln("@override");
  codeBuffer.writeln("bool operator ==(Object other){");
  codeBuffer.write("return identical(this, other) ||");
  codeBuffer.write(
      "(other is ${element.displayName.replaceFirst("_\$", "")} && runtimeType == other.runtimeType ");
  var str = "";
  visitor.constructorFields.forEach((e) {
    str += "&& ${e.name} == other.${e.name} ";
  });
  codeBuffer.write(str + ");");
  codeBuffer.writeln("}");
}

void generateToString(
  StringBuffer codeBuffer,
  Element element,
  DataClassVisitor visitor,
) {
  codeBuffer.writeln("@override");
  codeBuffer.writeln("String toString() {");
  codeBuffer.write("return \"${element.displayName.replaceFirst("_\$", "")}");
  codeBuffer.write("{");
  String str = "";
  visitor.constructorFields.forEach((e) {
    str += ("${e.name}: \$${e.name}, ");
  });
  codeBuffer.write(str.substring(0, str.lastIndexOf(",")));
  codeBuffer.write("}\";");
  codeBuffer.writeln("}");
}

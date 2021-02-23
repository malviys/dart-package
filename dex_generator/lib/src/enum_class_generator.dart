import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:dex_generator/src/annotation/enum.dart';
import 'package:source_gen/source_gen.dart';

class EnumClassGenerator extends GeneratorForAnnotation<EnumClass> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return _generateSourceClass(element);
  }
}

String _generateSourceClass(Element element) {
  assertEnumType(element);

  // store whole generated code
  final codeBuffer = StringBuffer();
  final visitor = EnumClassVisitor(element);

  print("fields: ${visitor.fields}");
  // class start
  codeBuffer.writeln("class ${element.displayName.substring(1)} {");

  // private constructor
  codeBuffer.writeln("const ${element.displayName.substring(1)}._();");

  // fields
  codeBuffer.write(enumFields(element));

  // class end
  codeBuffer.writeln("}");

  return codeBuffer.toString();
}

/// assert on enum object
/// where private and enum
void assertEnumType(Element element) {
  ClassElement e;
  try {
    e = element as ClassElement;
  } catch (error) {
    throw "${element.displayName} must be class check your definition.";
  }

  if (!e.isAbstract) {
    throw Exception(
      "@Enum can be applied only on abstract class check your definition or rename object type to enum.\n"
      "Failing at ${e.displayName}",
    );
  }

  if (!element.isPrivate) {
    throw Exception(
      "@Enum can be applied only on private abstract class check your definition or make your enum private.\n"
      "Failing at ${e.displayName}",
    );
  }
}

String enumFields(Element element) {
  final fieldsBuff = StringBuffer();
  final e = element as ClassElement;
  final className = e.displayName.substring(1);
  final constStr = "$className._();";

  e.fields.map((e) {
    fieldsBuff.writeln("static const $className ${e.displayName} = $constStr;");
  });

  return fieldsBuff.toString();
}

class EnumClassVisitor extends SimpleElementVisitor {
  final Element element;

  EnumClassVisitor(this.element);
  Set<dynamic> fields;


  @override
  visitClassElement(ClassElement element) {
    // fields.addAll(element.);
    return super.visitClassElement(element);
  }
}

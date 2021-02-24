import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:dex_generator/src/annotation/enum.dart';
import 'package:dex_generator/src/model/class_visitor.dart';
import 'package:dex_generator/src/utils/assertions.dart';
import 'package:dex_generator/src/utils/enum_class_generator_methods.dart';
import 'package:source_gen/source_gen.dart';

class EnumClassGenerator extends GeneratorForAnnotation<EnumClass> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    return _generateSourceClass(element);
  }
}

String _generateSourceClass(Element element) {
  assertClass(element);

  final codeBuffer = StringBuffer();
  final visitor = ClassVisitor();
  element.visitChildren(visitor);

  codeBuffer.writeln("class ${element.displayName.replaceAll("_\$", "")} {\n");
  codeBuffer.writeln("final String _name;\n");
  enumConstructor(codeBuffer, visitor);
  enumFields(codeBuffer, visitor);
  enumValuesConstant(codeBuffer, visitor);
  enumOrdinal(codeBuffer, visitor);
  enumValueOf(codeBuffer, visitor);
  enumToString(codeBuffer, visitor);
  codeBuffer.writeln("}");
  codeBuffer.writeln("// Generated class");

  return codeBuffer.toString();
}

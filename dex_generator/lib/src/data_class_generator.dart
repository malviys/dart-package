import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:dex_generator/src/annotation/data.dart';
import 'package:dex_generator/src/model/class_visitor.dart';
import 'package:dex_generator/src/utils/assertions.dart';
import 'package:dex_generator/src/utils/data_class_generator_methods.dart';
import 'package:dex_generator/src/utils/utils.dart';
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
  assertClass(element);

  final codeBuffer = StringBuffer();
  final visitor = ClassVisitor();
  element.visitChildren(visitor);

  codeBuffer.writeln("class ${getClassName(visitor.classType)} {\n");
  dataClassFields(codeBuffer, visitor);
  dataClassConstructor(codeBuffer, visitor);
  dataClassCopyWith(codeBuffer, visitor);
  dataClassFromMap(codeBuffer, visitor);
  dataClassToMap(codeBuffer,  visitor);
  dataClassHashCode(codeBuffer, visitor);
  dataClassEquals(codeBuffer, visitor);
  dataClassToString(codeBuffer, visitor);
  codeBuffer.writeln("}");
  codeBuffer.write("// Generated Successfully");

  return "${codeBuffer.toString()}";
}




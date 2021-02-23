import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:dex_generator/src/annotation/data.dart';
import 'package:dex_generator/src/model/ClassVisitor.dart';
import 'package:dex_generator/src/utils/assertions.dart';
import 'package:dex_generator/src/utils/generator_methods.dart';
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
  final visitor = ClassVisitor(element);

  element.visitChildren(visitor);

  // declaring class
  codeBuffer.write("class ${element.displayName.replaceFirst("_\$", "")} {");

  // fields
  fields(codeBuffer, visitor);

  // constructor
  constructor(codeBuffer, visitor);

  // copy with
  copyWith(codeBuffer, visitor);

  // from Map
  fromMap(codeBuffer, visitor);

  // to Map
  toMap(codeBuffer,  visitor);

  // hash code
  hashCode(codeBuffer, visitor);

  // equals
  equals(codeBuffer, visitor);

  // toString
  toString(codeBuffer, visitor);

  // end of class
  codeBuffer.writeln("}");

  // comment
  codeBuffer.write("// Generated Successfully");

  return "${codeBuffer.toString()}";
}




import 'package:dex_generator/src/model/class_visitor.dart';
import 'package:dex_generator/src/utils/utils.dart';

void enumFields(StringBuffer codeBuffer, ClassVisitor visitor) {
  final className = getClassName(visitor.classType);

  visitor.fields.forEach((field) {
    final fieldName = camelToUpperCase(field.name);

    return codeBuffer.writeln(
      "static const $className $fieldName = const $className._(\"$fieldName\");\n",
    );
  });
}

void enumConstructor(StringBuffer codeBuffer, ClassVisitor visitor) {
  final className = getClassName(visitor.classType);

  codeBuffer.writeln("const $className._(this._name);\n");
}

void enumToString(StringBuffer codeBuffer, ClassVisitor visitor) {
  final className = getClassName(visitor.classType);
  codeBuffer.writeln("@override String toString()=>\"$className.\$_name\";\n");
}

void enumValuesConstant(StringBuffer codeBuffer, ClassVisitor visitor) {
  codeBuffer.write("static const values = [");
  visitor.fields.forEach(
    (field) => codeBuffer.write(camelToUpperCase(field.name) + ","),
  );
  codeBuffer.writeln("];\n");
}

void enumOrdinal(StringBuffer codeBuffer, ClassVisitor visitor) {
  codeBuffer.write("int ordinal() {");
  codeBuffer.write("final ord = values.indexOf(this);");
  codeBuffer.write(
    "if (ord == -1) {throw Exception(\"Undefined Enum Type \$this\");}",
  );
  codeBuffer.writeln("return ord;}\n");
}

void enumValueOf(StringBuffer codeBuffer, ClassVisitor visitor) {
  codeBuffer.write("static Category valueOf(String name){");
  codeBuffer.write("values.forEach((value) {");
  codeBuffer.write(
    "final val = value._name.toLowerCase().replaceAll(\"_\", \"\");",
  );
  codeBuffer.write("if(val == name.toLowerCase()){return value;}");
  codeBuffer.write("});");
  codeBuffer.writeln("throw Exception(\"No such enum exists\");}\n");
}

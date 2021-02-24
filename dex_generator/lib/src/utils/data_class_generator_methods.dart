import 'package:dex_generator/src/model/class_visitor.dart';
import 'package:dex_generator/src/model/field.dart';
import 'package:dex_generator/src/utils/utils.dart';

//
// ================= Fields ===================
void dataClassFields(StringBuffer codeBuffer, ClassVisitor visitor) {
  // iterating over fields
  visitor.fields.forEach((field) => codeBuffer.writeln(field.finalField));
  codeBuffer.writeln();
}

// ================= Constructor ===================
void dataClassConstructor(StringBuffer codeBuffer, ClassVisitor visitor) {
  final className = getClassName(visitor.classType);

  codeBuffer.write("const $className({");

  visitor.fields.forEach((field) => codeBuffer.write(field.constructorField));

  codeBuffer.writeln("});\n");
}

// ================= Copy With ===================
void dataClassCopyWith(StringBuffer codeBuffer, ClassVisitor visitor) {
  final className = getClassName(visitor.classType);

  codeBuffer.write("$className copyWith({");
  visitor.fields.forEach((field) =>
      codeBuffer.write("${typeToProperForm(field.type)} ${field.name},"));
  codeBuffer.write("}){");
  codeBuffer.write("if(");
  var str = "";
  visitor.fields.forEach((e) {
    str += "(${e.name} == null || identical(${e.name}, this.${e.name})) && ";
  });
  codeBuffer.write(str.substring(0, str.lastIndexOf("&&")));
  codeBuffer.write("){");
  codeBuffer.write("return this;}");

  codeBuffer.write("return $className(");
  visitor.fields.forEach((e) {
    codeBuffer.write("${e.name}: ${e.name} ?? this.${e.name},");
  });
  codeBuffer.writeln(");}\n");
}

// ================= From Map ===================
void dataClassFromMap(StringBuffer codeBuffer, ClassVisitor visitor) {
  final className = getClassName(visitor.classType);

  codeBuffer.writeln("factory $className.fromMap(Map<String, dynamic> map) {");
  codeBuffer.writeln("return new $className(");

  visitor.fields.forEach(
    (field) => codeBuffer.write(
      "${field.name}: map['${field.name}'] as ${typeToProperForm(field.type)},",
    ),
  );

  codeBuffer.writeln(");}\n");
}

// ================= To Map ===================
void dataClassToMap(StringBuffer codeBuffer, ClassVisitor visitor) {
  codeBuffer.writeln("Map<String, dynamic> toMap() => {");
  visitor.fields.forEach((field) => codeBuffer.writeln("\"${field.name}\": ${field.name}"));
  codeBuffer.writeln("} as Map<String, dynamic>;\n");
}

// ================= Hash Code ===================
void dataClassHashCode(StringBuffer codeBuffer, ClassVisitor visitor) {
  codeBuffer.writeln("@override int get hashCode => ");

  var str = "";
  visitor.fields.forEach((e) {
    str += "${e.name}.hashCode ^ ";
  });

  codeBuffer.writeln(str.substring(0, str.lastIndexOf("^ ")) + ";\n");
}

// ================= Equals ===================
void dataClassEquals(StringBuffer codeBuffer, ClassVisitor visitor) {
  final className = getClassName(visitor.classType);

  codeBuffer.write("@override bool operator ==(Object other){");
  codeBuffer.write("return identical(this, other) ||");
  codeBuffer.write("(other is $className && runtimeType == other.runtimeType ");
  var str = "";
  visitor.fields.forEach((e) {
    str += "&& ${e.name} == other.${e.name} ";
  });
  codeBuffer.write(str + ");");
  codeBuffer.writeln("}\n");
}

// ================= To String ===================
void dataClassToString(StringBuffer codeBuffer, ClassVisitor visitor) {
  final className = getClassName(visitor.classType);

  var str = "@override String toString() => \"$className{";
  // iterating over fields
  visitor.fields.forEach((field) => str += field.field);
  // end of iteration

  str = str.substring(0, str.lastIndexOf(",")) + "}\";";
  codeBuffer.writeln("$str\n");
}

extension on Field {
  String get finalField => "final ${typeToProperForm(this.type)} ${this.name};";

  String get constructorField =>
      "${this.hasValue ? "this.${this.name} = ${this.value}" : "@required this.${this.name}"},";

  String get field => "${this.name}: \$${this.name}, ";
}

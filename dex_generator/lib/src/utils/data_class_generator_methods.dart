import 'package:dex_generator/src/model/ClassVisitor.dart';
import 'package:dex_generator/src/utils/utils.dart';

// ================= Fields ===================
void fields(StringBuffer codeBuffer, ClassVisitor visitor) {
  // iterating over fields
  visitor.fields.forEach((e) => codeBuffer.writeln(e.field));
}

// ================= Constructor ===================
void constructor(StringBuffer codeBuffer, ClassVisitor visitor) {
  final className = getClassName(visitor.element);

  codeBuffer.write("const $className({");

  visitor.fields.forEach(
    (e) => codeBuffer.write("${e.constructorField}"),
  );

  codeBuffer.write("});");
}

// ================= Copy With ===================
void copyWith(StringBuffer codeBuffer, ClassVisitor visitor) {
  final className = getClassName(visitor.element);

  codeBuffer.write("$className copyWith({");
  visitor.fields.forEach((e) => codeBuffer.write("${e.type} ${e.name},"));
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
  codeBuffer.write(");}");
}

// ================= From Map ===================
void fromMap(StringBuffer codeBuffer, ClassVisitor visitor) {
  final className = getClassName(visitor.element);

  codeBuffer.writeln("factory $className.fromMap(Map<String, dynamic> map) {");
  codeBuffer.writeln("return new $className(");

  visitor.fields.forEach((e) {
    codeBuffer.write("${e.name}: map['${e.name}'] as ${e.type},");
  });

  codeBuffer.writeln(");}");
}

// ================= To Map ===================
void toMap(StringBuffer codeBuffer, ClassVisitor visitor) {
  codeBuffer.writeln("Map<String, dynamic> toMap() => {");
  visitor.fields.forEach((e) {
    codeBuffer.writeln("${e.name} : this.${e.name},");
  });
  codeBuffer.writeln("} as Map<String, dynamic>;");
}

// ================= Hash Code ===================
void hashCode(StringBuffer codeBuffer, ClassVisitor visitor) {
  codeBuffer.writeln("@override int get hashCode => ");

  var str = "";
  visitor.fields.forEach((e) {
    str += "${e.name}.hashCode ^ ";
  });

  codeBuffer.write(str.substring(0, str.lastIndexOf("^ ")) + ";");
}

// ================= Equals ===================
void equals(StringBuffer codeBuffer, ClassVisitor visitor) {
  final className = getClassName(visitor.element);

  codeBuffer.writeln("@override bool operator ==(Object other){");
  codeBuffer.write("return identical(this, other) ||");
  codeBuffer.write("(other is $className && runtimeType == other.runtimeType ");
  var str = "";
  visitor.fields.forEach((e) {
    str += "&& ${e.name} == other.${e.name} ";
  });
  codeBuffer.write(str + ");");
  codeBuffer.writeln("}");
}

// ================= To String ===================
void toString(StringBuffer codeBuffer, ClassVisitor visitor) {
  final className = getClassName(visitor.element);

  codeBuffer.writeln("@override String toString() => \"$className {");

  // iterating over fields
  String str = "";
  visitor.fields.forEach((e) {
    str += ("${e.name}: \$${e.name}, ");
  });
  // end of iteration

  codeBuffer.write(str.substring(0, str.lastIndexOf(",")));
  codeBuffer.write("}\";}");
}

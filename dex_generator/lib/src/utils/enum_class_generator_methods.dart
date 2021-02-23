import 'package:dex_generator/src/model/ClassVisitor.dart';
import 'package:dex_generator/src/utils/utils.dart';

void enumFields(StringBuffer codeBuffer, ClassVisitor visitor) {
  final className = getClassName(visitor.element);

  visitor.fields.forEach(
    (field) => codeBuffer
        .write("static const $className ${field.name} = const $className._();"),
  );
}

void enumConstructor(StringBuffer codeBuffer, ClassVisitor visitor) {
  final className = getClassName(visitor.element);

  codeBuffer.write("const $className._();");
}

import 'package:analyzer/dart/element/type.dart';

String getClassName(DartType type) =>
    type.getDisplayString(withNullability: false).replaceFirst("_\$", "");

String camelToUpperCase(String text) {
  RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');

  return text
      .replaceAllMapped(exp, (Match m) => ('_' + m.group(0)))
      .toUpperCase();
}

String typeToProperForm(DartType type) {
  final string = type.toString();

  if (string.contains("*")) {
    return string.replaceAll("*", "");
  }

  return string;
}

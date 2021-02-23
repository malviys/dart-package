import 'package:analyzer/dart/element/element.dart';

void assertClass(Element element) {
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



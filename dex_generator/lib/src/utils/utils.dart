import 'package:analyzer/dart/element/element.dart';

String getClassName(Element element) =>
    element.displayName.replaceFirst("_\$", "");

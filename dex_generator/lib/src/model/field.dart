import 'package:analyzer/dart/element/type.dart';

class Field {
  final DartType type;
  final String name;
  final String value;
  final bool hasValue;

  const Field({
    this.type,
    this.name,
    this.value,
    this.hasValue,
  });

  @override
  String toString() {
    return 'Field{type: $type, name: $name, value: $value, hasValue: $hasValue}';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum_test.dart';

// **************************************************************************
// EnumClassGenerator
// **************************************************************************

class Category {
  final String _name;

  const Category._(this._name);

  static const Category ONE = const Category._("ONE");

  static const Category TWO = const Category._("TWO");

  static const Category THREE = const Category._("THREE");

  static const values = [
    ONE,
    TWO,
    THREE,
  ];

  @override
  String toString() => "Category.$_name";

  int ordinal() {
    final ord = values.indexOf(this);
    if (ord == -1) {
      throw Exception("Undefined Enum Type $this");
    }
    return ord;
  }

  static Category valueOf(String name) {
    values.forEach((value) {
      final val = value._name.toLowerCase().replaceAll("_", "");
      if (val == name.toLowerCase()) {
        return value;
      }
    });
    throw Exception("No such enum exists");
  }
}
// Generated class


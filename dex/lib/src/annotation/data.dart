class DataClass {
  const DataClass._();
}

/// Classes with @Enum annotations are used as reference to generate original Enum classes
///
///
/// ```dart
/// @Data
/// class _$Person{
///   _$A(int age, String name, {String dob = "1/1/0000});
/// }
/// ```
///
/// ============= Generate Code =================
/// ```dart
/// class Person{
///   final int age;
///   final String name;
///   final String dob;
///
///   const Person({
///   @required this.age,
///   @required this.name,
///   this.dob = "1/1/0000",
///   });
///
///   Person copyWith()
///     ....
///
///   Person fromMap(Map)
///     ....
///
///   Map toMap()
///     ....
///
///   int hashCode
///
///   bool equals
/// }
/// ```
const DataClass Data = DataClass._();

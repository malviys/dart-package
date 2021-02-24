class EnumClass {
  const EnumClass._();
}


/// Classes with @Data annotations are used as reference to generate original Data classes
///
///
/// ```dart
/// @Enum
/// class _$Car{
///  _$A(bmw, honda, audi);
/// }
/// ```
///
/// ================== Generated Code ==================
/// ```dart
/// class Car{
///   static const Car BMW;
///   static const Car Honda;
///   static const Car audi;
/// }
/// ```
const Enum = EnumClass._();

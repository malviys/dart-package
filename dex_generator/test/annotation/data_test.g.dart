// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_test.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

class Person {
  final int age;

  const Person({
    @required this.age,
  });

  Person copyWith({
    int age,
  }) {
    if ((age == null || identical(age, this.age))) {
      return this;
    }
    return Person(
      age: age ?? this.age,
    );
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return new Person(
      age: map['age'] as int,
    );
  }

  Map<String, dynamic> toMap() => {
        "age": age,
      } as Map<String, dynamic>;

  @override
  int get hashCode => age.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Person &&
            runtimeType == other.runtimeType &&
            age == other.age);
  }

  @override
  String toString() => "Person{age: $age}";
}
// Generated Successfully

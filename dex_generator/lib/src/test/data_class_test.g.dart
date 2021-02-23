// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_class_test.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

class Person {
  final int age;
  final String name;
  final int dob;

  const Person({
    @required this.age,
    @required this.name,
    @required this.dob,
  });

  Person copyWith({
    int age,
    String name,
    int dob,
  }) {
    if ((age == null || identical(age, this.age)) &&
        (name == null || identical(name, this.name)) &&
        (dob == null || identical(dob, this.dob))) {
      return this;
    }
    return Person(
      age: age ?? this.age,
      name: name ?? this.name,
      dob: dob ?? this.dob,
    );
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return new Person(
      age: map['age'] as int,
      name: map['name'] as String,
      dob: map['dob'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      age: this.age,
      name: this.name,
      dob: this.dob,
    } as Map<String, dynamic>;
  }

  @override
  int get hashCode {
    return age.hashCode ^ name.hashCode ^ dob.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Person &&
            runtimeType == other.runtimeType &&
            age == other.age &&
            name == other.name &&
            dob == other.dob);
  }

  @override
  String toString() {
    return "Person{age: $age, name: $name, dob: $dob}";
  }
}
// Generated Successfully

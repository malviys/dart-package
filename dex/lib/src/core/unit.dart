import 'package:flutter/foundation.dart';

/// Single unit or value
class Unit {
  const Unit._();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Unit && true;
  }

  @override
  int get hashCode => 1;

  @override
  String toString() => "Unit";
}

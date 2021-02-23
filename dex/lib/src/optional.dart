import 'package:dex/src/core/exception.dart';

/// Optional represents a object that contains either none or a value
class Optional<T> {
  T _value;

  Optional({T value}) {
    _value = value;
  }

  /// Empty optional
  static Optional<T> empty<T>() {
    return emptyOptional;
  }

  /// Return whether value is present or not
  bool get isEmpty => _value == null ? true : false;

  /// If value is present then call the function
  void ifPresent(void Function(T value) fun) {
    if (!isEmpty) {
      fun(_value);
    }
  }

  /// Return optional with value if it's null.
  Optional optional(T value) {
    if (isEmpty) {
      return Optional(value: value);
    }

    return this;
  }

  T get() {
    if (isEmpty) {
      throw NoSuchElementException();
    }
    return _value;
  }

  T getOrElse(T Function() fun) {
    if (isEmpty) {
      return fun();
    }
    return _value;
  }

  T getOrThrow(Exception e) {
    if (isEmpty) {
      throw e;
    }
    return _value;
  }

  Optional<T> filter(bool Function(T value) predicate) {
    if (predicate(_value)) {
      return this;
    }

    return empty();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Optional &&
          runtimeType == other.runtimeType &&
          _value == other._value;

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() {
    return 'Optional{value: $_value}';
  }
}

/// Empty Optional
class EmptyOptional<T> extends Optional<T> {
  EmptyOptional._(T value) : super(value: value);

  @override
  T get() => throw NoSuchElementException();

  @override
  String toString() {
    return 'Optional{}';
  }
}

Optional get emptyOptional => EmptyOptional._(null);

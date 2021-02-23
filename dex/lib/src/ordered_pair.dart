/// Object representation of 2-dimensional point in space
class Pair<T1, T2> {
  final T1 first;
  final T2 second;

  Pair({this.first, this.second});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pair &&
          runtimeType == other.runtimeType &&
          first == other.first &&
          second == other.second;

  @override
  int get hashCode => first.hashCode ^ second.hashCode;

  @override
  String toString() {
    return 'Pair{_first: $first, _second: $second}';
  }
}

/// Object representation of 3-dimensional point in space
class Triplet<T1, T2, T3> {
  final T1 first;
  final T2 second;
  final T3 third;

  Triplet({this.first, this.second, this.third});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Triplet &&
          runtimeType == other.runtimeType &&
          first == other.first &&
          second == other.second &&
          third == other.third;

  @override
  int get hashCode => first.hashCode ^ second.hashCode ^ third.hashCode;

  @override
  String toString() {
    return 'Triplet{_first: $first, _second: $second, _third: $third}';
  }
}

/// Object representation of 4-dimensional point in space
class Quadruplet<T1, T2, T3, T4> {
  final T1 first;
  final T2 second;
  final T3 third;
  final T4 fourth;

  Quadruplet({this.first, this.second, this.third, this.fourth});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Quadruplet &&
          runtimeType == other.runtimeType &&
          first == other.first &&
          second == other.second &&
          third == other.third &&
          fourth == other.fourth;

  @override
  int get hashCode =>
      first.hashCode ^ second.hashCode ^ third.hashCode ^ fourth.hashCode;

  @override
  String toString() {
    return 'Quadruplet{first: $first, second: $second, third: $third, fourth: $fourth}';
  }
}

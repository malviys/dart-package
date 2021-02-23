class NoSuchElementException implements Exception{
  final String message;

  NoSuchElementException({this.message});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoSuchElementException &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() {
    return 'NoSuchException{message: $message}';
  }
}
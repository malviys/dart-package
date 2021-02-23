extension ScopedFunction on Object {
  /// let takes object on which it is invoked and passes it as parameter to the
  /// block and return the value of block
  R let<T, R>(R Function(T it) block) {
    return block(this);
  }

  /// also takes object on which it is invoked and passes it as parameter to the block
  /// and return the original object
  T also<T>(void Function(T it) block) {
    block(this);
    return this;
  }
}

T identity<T>(T it) => it;

void repeat(int times, void Function(int idx) block) {
  for (int i = 0; i < times; ++i) block(i);
}

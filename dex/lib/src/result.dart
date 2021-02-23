/// <h1>Result</h1> represents the result return by a function, or API.
/// If call is successful then it represents the <strong>Success</strong> with value,
/// else if call is failure then it represents the <strong>Failure</strong>
/// with error.
abstract class Result<S, F> {
  /// Unfolds the value enclosed inside the result
  unFold(Function(S value) onSuccess, Function(F error) onFailure) {
    if (this is Success) {
      return onSuccess((this as Success).value);
    } else if (this is Failure) {
      return onFailure((this as Failure).error);
    }
    throw TypeError();
  }

  /// Get value on success or return the given function
  S getOrElse(S Function() fun) {
    if (this is Success) return (this as Success).value;

    return fun();
  }

  /// Get value or throw exception
  S getOrThrow(dynamic e) {
    if (this is Success) return (this as Success).value;

    throw e;
  }

  /// If result is success
  bool get isSuccess => this is Success;
}

/// <h1>Success</h1> representation an operation is performed successfully
class Success<S, F> extends Result<S, F> {
  final S value;

  Success(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Success &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => super.hashCode ^ value.hashCode;

  @override
  String toString() {
    return 'Success{value: $value}';
  }
}

/// <h1>Failure</h1> representation an operation is performed with failure
class Failure<S, F> extends Result<S, F> {
  final F error;

  Failure(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is Failure &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => super.hashCode ^ error.hashCode;

  @override
  String toString() {
    return 'Failure{error: $error}';
  }
}

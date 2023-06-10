sealed class Response {}

class OnSuccess<T> extends Response {
  final T _result;

  OnSuccess(this._result);

  T get result => _result;
}

class OnFailure<T> extends Response {
  final T _result;

  OnFailure(this._result);

  T get result => _result;
}

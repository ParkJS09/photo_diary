sealed class NetworkResponse<T> {}

class ResponseSuccess<T> extends NetworkResponse {
  final T _result;

  ResponseSuccess(this._result);

  T get result => _result;
}

class ResponseFailed<T> extends NetworkResponse {
  final T _result;

  ResponseFailed(this._result);

  T get result => _result;
}

class ResponseError<T> extends NetworkResponse {
  final T _result;

  ResponseError(this._result);

  T get result => _result;
}

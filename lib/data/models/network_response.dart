class NetworkResult<T> {
  final T data;
  NetworkResult({required this.data});
}

class NetworkSucess<T> {
  final T data;
  NetworkSucess({required this.data});
}

class NetworkFail<T> {
  final T data;
  NetworkFail({required this.data});
}

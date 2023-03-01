import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_response.freezed.dart';

class NetworkResult<T> {
  final T data;
  NetworkResult({required this.data});
}

class NetworkSuccess<T> {
  final T data;
  NetworkSuccess({required this.data});
}

class NetworkFail<T> {
  final T data;
  NetworkFail({required this.data});
}

@freezed
class Result<T> with _$Result<T> {
  const factory Result.success({required T data}) = Success<T>;
  const factory Result.failure({required T data}) = Failure<T>;
  const factory Result.error({required String message}) = Error<T>;
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:today/data/models/network_response.dart';

abstract class AuthRepository {
  Future<User?> currentUser();
  Future<NetworkResult> onSignIn({
    required String email, // 이메일
    required String password, // 비밀번호
  });

  Future<void> onSignUp({
    required String email, // 이메일
    required String password, // 비밀번호
    required Function() onSuccess, // 가입 성공시 호출되는 함수
    required Function(String err) onError, // 에러 발생시 호출되는 함수
  });

  Future<void> onSignOut();
}
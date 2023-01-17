import 'package:firebase_auth/firebase_auth.dart';
import 'package:today/config/di/di.dart';
import 'package:today/data/models/network_response.dart';
import 'package:today/data/repository/auth_repository.dart';

class AuthUseCase {
  late AuthRepository authRepository;

  AuthUseCase(){
    authRepository = getIt.get<AuthRepository>();
  }

  Future<User?> getCurrentUser() {
    return authRepository.currentUser();
  }

  Future<NetworkResult> onSignIn({
    required String email, // 이메일
    required String password, // 비밀번호
  }) async {
    return await authRepository.onSignIn(email: email, password: password);
  }

  Future<void> onSignUp({
    required String email, // 이메일
    required String password, // 비밀번호
  }) async {

  }
}

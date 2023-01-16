import 'package:firebase_auth/firebase_auth.dart';
import 'package:today/data/repository/auth_repository.dart';

class AuthUseCase {
  final AuthRepository authRepository;
  AuthUseCase({required this.authRepository});

  Future<User?> getCurrentUser() {
      return authRepository.currentUser();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:today/data/models/network_response.dart';

abstract class AuthRepository {
  Future<User?> currentUser();
  Future<Result> onSignIn({
    required String email,
    required String password
  });

  Future<Result> onSignUp({
    required String email,
    required String password
  });

  Future<void> onSignOut();
}
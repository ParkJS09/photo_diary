import 'package:firebase_auth/firebase_auth.dart';
import 'package:today/data/models/network_response.dart';
import 'package:today/data/models/network_reuslt.dart' as newNetwork;

abstract class AuthRepository {
  Future<User?> currentUser();

  Future<newNetwork.NetworkResponse> onNewSignIn({
    required String email,
    required String password
  });

  Future<Result> onSignUp({
    required String email,
    required String password
  });

  Future<void> onSignOut();
}
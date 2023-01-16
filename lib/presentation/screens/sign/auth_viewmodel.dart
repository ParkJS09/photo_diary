import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:today/domain/auth_usecase.dart';

class AuthViewModel extends ChangeNotifier {
  AuthUseCase authUseCase;

  AuthViewModel({required this.authUseCase});

  User? user;

  void getCurrentUser() async {
    user = await authUseCase.getCurrentUser();
    notifyListeners();
  }

  void onSignUp() async {

  }
}

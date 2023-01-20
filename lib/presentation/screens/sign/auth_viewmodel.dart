import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:today/config/di/di.dart';
import 'package:today/domain/auth_usecase.dart';

class AuthViewModel extends ChangeNotifier {
  late AuthUseCase authUseCase;

  AuthViewModel(){
    authUseCase = getIt.get<AuthUseCase>();
  }

  User? user;

  void getCurrentUser() async {
    user = await authUseCase.getCurrentUser();
    notifyListeners();
  }

  void onSignIn(String email, String password) async {
    log('onSignIn---------------------');
    var result = await authUseCase.onSignIn(
        email: email,
        password: password
    );
    log('result -> $result');
    result.when(
        success: (data){
          user = data;
        },
        failure: (data) {
          log('failure msg -> $data');
        },
        error: (message) {
          log('error msg -> $message');
        },
    );
    notifyListeners();
  }

  void onSignUp(String email, String password) async {
    log('onSignUp---------------------');
    var result = await authUseCase.onSignUp(
        email: email,
        password: password
    );
    result.when(
      success: (data){
        user = data;
      },
      failure: (data) {
        log('failure msg -> $data');
      },
      error: (message) {
        log('error msg -> $message');
      },
    );
    notifyListeners();
  }
}
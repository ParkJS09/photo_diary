import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:today/config/di/di.dart';
import 'package:today/data/models/network_response.dart';
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
    NetworkResult result = await authUseCase.onSignIn(
        email: email,
        password: password
    );
    log('result : $result');
    log('result.data : ${result.data}');
    switch(result.data){
      case NetworkSucess :
        log('NetworkSucess : ${result.data.data}');
        break;
      case NetworkFail :
        log('NetworkFail : ${result.data}');
        String errMsg = result.data;
        log('NetworkFail_errMsg : $errMsg');
        break;
    }
  }

  void onSignUp() async {

  }
}

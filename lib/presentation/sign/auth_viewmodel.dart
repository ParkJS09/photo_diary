import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:today/config/di/di.dart';
import 'package:today/domain/auth/login_auth_usecase.dart';
import 'package:today/domain/auth_usecase.dart';
import 'package:today/domain/models/common_network.dart';
import 'package:today/domain/models/user_model.dart';
import 'package:today/presentation/sign/auth_state.dart';

class AuthViewModel extends ChangeNotifier {
  late AuthUseCase authUseCase;
  late LoginAuthUsecase loginAuthUsecase;
  AuthState _authState = UnAuthenticatedState();

  AuthViewModel() {
    authUseCase = getIt.get<AuthUseCase>();
    loginAuthUsecase = getIt.get<LoginAuthUsecase>();
  }

  User? _user;

  User? get user => _user;

  AuthState get authState {
    return _authState;
  }

  void getCurrentUser() async {
    _user = await authUseCase.getCurrentUser();
    notifyListeners();
  }

  void onSignIn(String email, String password) async {
    await loginAuthUsecase
        .onSignIn(email: email, password: password)
        .then((response) {
          switch (response) {
            case OnSuccess(result: UserModel userModel):
              log('onSuccess...${userModel.toString()}');
                _authState = AuthenticatedState(userModel.email??'dd');
                notifyListeners();
                break;
            case OnFailure<String>(result: String failure):
              log('onFailure....$failure');
              _authState = UnAuthenticatedState();
              notifyListeners();
              break;
            default:
              log('wtf');
              _authState = AuthenticatedState('dd');
              notifyListeners();
              break;
          }
        }).catchError((onError) {
          log('error -> $onError');
        });

  }

  void onSignUp(String email, String password) async {
    var result = await authUseCase.onSignUp(email: email, password: password);
    result.when(
      success: (data) {
        _user = data;
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

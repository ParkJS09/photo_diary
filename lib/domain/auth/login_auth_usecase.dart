import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:today/config/di/di.dart';
import 'package:today/data/models/network_response.dart';
import 'package:today/data/models/network_reuslt.dart';
import 'package:today/domain/models/common_network.dart';
import 'package:today/domain/models/user_model.dart';
import 'package:today/domain/repository/auth_repository.dart';

class LoginAuthUsecase {
  late AuthRepository authRepository;

  LoginAuthUsecase() {
    authRepository = getIt.get<AuthRepository>();
  }

  Future<Response> onSignIn({
    required String email, // 이메일
    required String password, // 비밀번호
  }) async {
    return await authRepository
        .onNewSignIn(email: email, password: password)
        .then((result) {
      switch (result) {
        case ResponseSuccess(result: final result):{
            return OnSuccess(result as UserModel);
        }
        case ResponseFailed(result: final result):{
            return OnFailure(result);
        }
        case ResponseError(result: final result):{
            return OnFailure(result);
        }
      }
    }).catchError((error) {
      return OnFailure(error);
    });
  }
}

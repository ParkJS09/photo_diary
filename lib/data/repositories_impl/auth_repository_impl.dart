import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:today/data/models/network_response.dart';
import 'package:today/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User?> currentUser() async {
    // 현재 유저(로그인 되지 않은 경우 null 반환)
    FirebaseAuth.instance.currentUser;
  }

  @override
  Future<void> onSignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<Result> onSignIn({
    required String email,
    required String password,
  }) async {
    // 로그인 시도
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('userCredential...');
      return Result.success(data: userCredential.user);
    } on FirebaseAuthException catch (e) {
      // firebase auth 에러 발생
      return Result.failure(data: e.message ?? '에러가 발생하였습니다.');
    } catch (e) {
      // Firebase auth 이외의 에러 발생
      return Result.error(message: e.toString());
    }
  }

  @override
  Future<Result> onSignUp({
    required String email,
    required String password,
  }) async {
    // firebase auth 회원 가입
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Result.success(data: userCredential.user);
    } on FirebaseAuthException catch (e) {
      // Firebase auth 에러 발생
      String errMsg = '';
      if (e.message != null) {
        if (e.code == 'weak-password') {
          errMsg = '비밀번호를 6자리 이상 입력해 주세요.';
        } else if (e.code == 'email-already-in-use') {
          errMsg = '이미 가입된 이메일 입니다.';
        } else if (e.code == 'invalid-email') {
          errMsg = '이메일 형식을 확인해주세요.';
        } else if (e.code == 'user-not-found') {
          errMsg = '일치하는 이메일이 없습니다.';
        } else if (e.code == 'wrong-password') {
          errMsg = '비밀번호가 일치하지 않습니다.';
        } else {
          errMsg = e.message!;
        }
      } else {
        errMsg = '에러가 발생하였습니다.';
      }
      return Result.failure(data: errMsg);
    } catch (e) {
      // Firebase auth 이외의 에러 발생
      return Result.error(message: e.toString());
    }
  }
}

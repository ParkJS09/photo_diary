import 'package:firebase_auth/firebase_auth.dart';
import 'package:today/domain/models/user_model.dart';

extension DomainMapper on User? {
  UserModel? toUserModel() {
    if (this != null) {
      return UserModel(
        uid: this!.uid, // null 체크 후 접근
        email: this!.email, // null 체크 후 접근
        refreshToken: this!.refreshToken, // null 체크 후 접근
      );
    }
    return null;
  }
}

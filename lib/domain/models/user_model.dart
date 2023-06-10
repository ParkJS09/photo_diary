class UserModel {
  final String? email;
  final String? uid;
  final String? refreshToken;

  UserModel({required this.email, required this.uid, required this.refreshToken});

  @override
  String toString() {
    return 'UserModel{email: $email, uid: $uid, refreshToken: $refreshToken}';
  }
}

sealed class AuthState {}

class AuthenticatedState implements AuthState {
  final String _id;

  AuthenticatedState(this._id);

  String get userId => _id;
}

class UnAuthenticatedState implements AuthState {
  UnAuthenticatedState();
}

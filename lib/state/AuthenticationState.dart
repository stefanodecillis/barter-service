class AuthenticationState {
  AuthenticationState._();

  bool isLoggedIn;

  factory AuthenticationState.initial() {
    return AuthenticationState._()..isLoggedIn = false;
  }
}

abstract class AuthenticationEvent {}

class Login extends AuthenticationEvent {
  final String email;
  final String psw;
  Login({this.email, this.psw});
}

class Signup extends AuthenticationEvent {
  final String email;
  final String psw;
  final String username;
  Signup({this.email, this.psw, this.username});
}

class Logout extends AuthenticationEvent {}

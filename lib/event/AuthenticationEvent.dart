import 'package:flutter/cupertino.dart';

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
  final BuildContext context;
  Signup({this.email, this.psw, this.username, this.context});
}

class Signin extends AuthenticationEvent {
  final String email;
  final String psw;
  final BuildContext context;
  final VoidCallback onSignin;
  Signin({this.email, this.psw, this.context, this.onSignin});
}

class Logout extends AuthenticationEvent {}

class FacebookSignIn extends AuthenticationEvent {
  final String email;
  FacebookSignIn({this.email});
}

class GoogleSignIn extends AuthenticationEvent {}

class GoogleSignUp extends AuthenticationEvent {}

class FacebookSignUp extends AuthenticationEvent {}

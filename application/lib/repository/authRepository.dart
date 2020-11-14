import 'package:barter/provider/authentications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthRepository {
  AuthenticationProvider _provider = new AuthenticationProvider();

  Future<FirebaseUser> signIn(String email, String password, BuildContext context) => _provider.signin(email, password, context);
  Future<FirebaseUser> signUp(String email, String password, String username, BuildContext context) => _provider.signUp(email, password, username, context);
  Future signOut() => _provider.signOutUser();
  Future<String> googleSignIn() => _provider.googleSignIn();
  Future<bool> facebookSignIn () => _provider.SignInFacebook();
  Future<bool> googleSignUp() => _provider.googleSignUp();
  Future<bool> facebookSignUp () => _provider.SignUpFacebook();

}

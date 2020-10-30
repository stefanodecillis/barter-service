import 'package:barter/screen/authentication/signin.dart';
import 'package:barter/screen/authentication/signup.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {

  Authenticate({this.onSignIn});
  final VoidCallback onSignIn;

  @override
  _AuthenticateState createState() => _AuthenticateState(onSignIn: onSignIn);
}

class _AuthenticateState extends State<Authenticate> {

  _AuthenticateState({this.onSignIn});
  final VoidCallback onSignIn;

  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(onSignIn: onSignIn,);
    } else {
      //return SignUp(toggleView);
      return SignUp(onSignIn: onSignIn,);
    }
  }
}

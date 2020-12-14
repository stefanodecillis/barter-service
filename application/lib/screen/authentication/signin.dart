import 'package:barter/event/AuthenticationEvent.dart';
import 'package:barter/handler/coreLogic.dart';
import 'package:barter/handler/helperfunctions.dart';
import 'package:barter/provider/auth.dart';
import 'package:barter/provider/authentications.dart';
import 'package:barter/provider/database.dart';
import 'package:barter/screen/authentication/signup.dart';
import 'package:barter/screen/chat/chatrooms.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class SignIn extends StatefulWidget {
  //final Function toggleView;

  SignIn({this.onSignIn});
  final VoidCallback onSignIn;

  //SignIn(this.toggleView);
  @override
  _SignInState createState() => _SignInState(onSignIn: onSignIn);
}

class _SignInState extends State<SignIn> {
  _SignInState({this.onSignIn});
  final VoidCallback onSignIn;

  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController usernameEditingController = new TextEditingController();
  String email;
  String password;
  AuthService authService = new AuthService();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signInWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then((result) async {
        if (result != null) {
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(emailEditingController.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.myName=(userInfoSnapshot.documents[0].data["username"]);
          debugPrint("1");
          debugPrint(HelperFunctions.myName);
          debugPrint(userInfoSnapshot.documents[0].data["username"]);
          debugPrint("2");
          debugPrint(userInfoSnapshot.documents[0].data["email"]);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.documents[0].data["username"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.documents[0].data["email"]);

          onSignIn();
        } else {
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }
      });
    }
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          //style: kLabelStyle,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [secondTheme, Colors.red]))),
        SafeArea(
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image(
                    image: AssetImage(
                      'assets/logos/Accounting.png',
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: secondBg,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      controller: emailEditingController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      onChanged: (val) {
                        email = val;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.email,
                          color: secondTheme,
                        ),
                        hintText: 'Enter your Email',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: secondBg,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      controller: passwordEditingController,
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      onChanged: (val) {
                        password = val;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: secondTheme,
                        ),
                        hintText: 'Enter your Password',
                        hintStyle: kHintTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: RaisedButton(
                        onPressed: () => CoreLogic.instance.authenticationLogic.add(Signin(email:email.trim(), psw:password.trim(), context:context)),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        disabledColor: secondBg,
                        child: Text(
                          "LOGIN",
                          style: TextStyle(color: secondTheme, fontSize: 21),
                        )),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RaisedButton(
                        onPressed: () => {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUp()))
                            },
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        disabledColor: secondBg,
                        child: Text(
                          "Signup",
                          style: TextStyle(color: secondTheme, fontSize: 19),
                        )),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

class ClassicBtn extends StatelessWidget {
  final Function onPress;
  final String title;
  ClassicBtn({this.onPress, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.5,
      child: RaisedButton(
          onPressed: onPress(),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          disabledColor: secondBg,
          child: Text(
            this.title,
            style: TextStyle(color: secondTheme, fontSize: 21),
          )),
    );
  }
}

import 'package:barter/event/AuthenticationEvent.dart';
import 'package:barter/handler/coreLogic.dart';
import 'package:barter/handler/helperfunctions.dart';
import 'package:barter/provider/auth.dart';
import 'package:barter/provider/authentications.dart';
import 'package:barter/provider/database.dart';
import 'package:barter/screen/chat/chatrooms.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';


class SignUp extends StatefulWidget {
  //final Function toggleView;
  //SignUp(this.toggleView);
  SignUp({this.onSignIn});
  final VoidCallback onSignIn;

  @override
  _SignUpState createState() => _SignUpState(onSignIn: onSignIn);
}

class _SignUpState extends State<SignUp> {

  _SignUpState({this.onSignIn});
  final VoidCallback onSignIn;

  String email;
  String password;
  String userName;
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController confirmPasswordEditingController = new TextEditingController();
  TextEditingController usernameEditingController =      new TextEditingController();

  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  singUp() async {

    if(formKey.currentState.validate()){
      setState(() {

        isLoading = true;
      });

      await authService.signUpWithEmailAndPassword(emailEditingController.text,
          passwordEditingController.text).then((result){
            if(result != null){
              Map<String,String> userDataMap = {
                "username" : usernameEditingController.text,
                "email" : emailEditingController.text
              };

              databaseMethods.addUserInfo(userDataMap);

              HelperFunctions.saveUserLoggedInSharedPreference(true);
              HelperFunctions.saveUserNameSharedPreference(userName);
              HelperFunctions.saveUserEmailSharedPreference(email);
              HelperFunctions.myName=userName;
              onSignIn();
            }
      });
    }
  }
  Widget _builduserNameTF() {
    return Container(
      decoration: BoxDecoration(
          color: secondBg,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: usernameEditingController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'OpenSans',
        ),
        onChanged: (val) {
          userName= val;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.person,
            color: secondTheme,
          ),
          hintText: 'Enter your Username',
        ),
      ),
    );

  }

  Widget _buildEmailTF() {
    return Container(
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
          hintText: 'Enter your email',
        ),
      ),
    );
  }

  Widget _buildPasswordTF() {
    return Container(
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
    );
  }

  Widget _buildConfirmPasswordTF() {
    return Container(
      decoration: BoxDecoration(
          color: secondBg,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: confirmPasswordEditingController,
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
          hintText: 'Confirm your Password',
          hintStyle: kHintTextStyle,
        ),
      ),
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

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
                () => /*SignUpFacebook().whenComplete(() async {
                  FirebaseUser user = await FirebaseAuth.instance.currentUser();

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ChatRoom()));
                })*/CoreLogic.instance.authenticationLogic.add(FacebookSignUp()),
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
                () => /*googleSignUp().whenComplete(() async {
              FirebaseUser user = await FirebaseAuth.instance.currentUser();

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ChatRoom()));
            })*/CoreLogic.instance.authenticationLogic.add(GoogleSignUp()),
            AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
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
                      _builduserNameTF(),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(), SizedBox(
                        height: 30.0,
                      ),

                      _buildConfirmPasswordTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: RaisedButton(
                            onPressed: () {
                              if(passwordEditingController.text != confirmPasswordEditingController.text){
                                debugPrint("password doesn't match"); //todo make alert and trim email and password
                                return null;
                                }
                              print(email+password+userName);
                              CoreLogic.instance.authenticationLogic.add(Signup(email:email.trim(), psw:password, username:userName, context:context));
                            } ,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            disabledColor: secondBg,
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(color: secondTheme, fontSize: 21),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

}

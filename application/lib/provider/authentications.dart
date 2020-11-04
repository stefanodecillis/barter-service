import 'dart:convert';

import 'package:barter/handler/helperfunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

import 'database.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
// a simple sialog to be visible everytime some error occurs
showErrDialog(BuildContext context, String err) {
  // to hide the keyboard, if it is still p
  FocusScope.of(context).requestFocus(new FocusNode());
  return showDialog(
    context: context,
    child: AlertDialog(
      title: Text("Error"),
      content: Text(err),
      actions: <Widget>[
        OutlineButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok"),
        ),
      ],
    ),
  );
}

// many unhandled google error exist
// will push them soon
Future<bool> SignInFacebook() async {
//    2407536649-ZFNGnaMhK7tCHBYL4rQ2SGT9nkuTbnL8g3aJCxq acc token
//    Niz5D73o0BaUMZU4GHHGCTSpJmIoxmoPIITPeuOH46SMO acc token secret
  FacebookLogin facebookLogin = FacebookLogin();

  final result = await facebookLogin.logIn(['email']);
  final token = result.accessToken.token;
  final graphResponse = await http.get(
      'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name&access_token=${token}');
  print(graphResponse.body);
  var profile = json.decode(graphResponse.body);
  if (result.status == FacebookLoginStatus.loggedIn) {
    HelperFunctions.saveUserLoggedInSharedPreference(true);
    HelperFunctions.saveUserNameSharedPreference(profile['name'].toString());
    HelperFunctions.saveUserEmailSharedPreference(
        profile['email'].toString().replaceAll('\u0040', '@'));
    final credential = FacebookAuthProvider.getCredential(accessToken: token);
    _auth.signInWithCredential(credential);
    return Future.value(true);
  } else {
    return Future.value(null);
  }
}

Future<String> googleSignIn() async {
  GoogleSignInAccount googleSignInAccount = await gooleSignIn.signIn();

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = await auth.signInWithCredential(credential);

    FirebaseUser user = await auth.currentUser();
    print(user.uid);
    if (result != null) {
      HelperFunctions.saveUserLoggedInSharedPreference(true);
      HelperFunctions.saveUserNameSharedPreference(user.displayName);
      HelperFunctions.saveUserEmailSharedPreference(user.email);
      return Future.value(user.email);
    } else {
      return Future.value(null);
    }
  }
}

// instead of returning true or false
// returning user to directly access UserID
Future<FirebaseUser> signin(
    String email, String password, BuildContext context) async {
  try {
    AuthResult result =
        await auth.signInWithEmailAndPassword(email: email, password: email);
    FirebaseUser user = result.user;
    // return Future.value(true);
    HelperFunctions.saveUserLoggedInSharedPreference(true);
    HelperFunctions.saveUserNameSharedPreference(email);
    HelperFunctions.saveUserEmailSharedPreference(email);
    return Future.value(user);
  } catch (e) {
    // simply passing error code as a message
    print(e.code);
    switch (e.code) {
      case 'ERROR_INVALID_EMAIL':
        showErrDialog(context, e.code);
        break;
      case 'ERROR_WRONG_PASSWORD':
        showErrDialog(context, e.code);
        break;
      case 'ERROR_USER_NOT_FOUND':
        showErrDialog(context, e.code);
        break;
      case 'ERROR_USER_DISABLED':
        showErrDialog(context, e.code);
        break;
      case 'ERROR_TOO_MANY_REQUESTS':
        showErrDialog(context, e.code);
        break;
      case 'ERROR_OPERATION_NOT_ALLOWED':
        showErrDialog(context, e.code);
        break;
    }
    // since we are not actually continuing after displaying errors
    // the false value will not be returned
    // hence we don't have to check the valur returned in from the signin function
    // whenever we call it anywhere
    return Future.value(null);
  }
}

// change to Future<FirebaseUser> for returning a user
Future<FirebaseUser> signUp(String email, String password, String userName,
    BuildContext context) async {
  try {
    DatabaseMethods databaseMethods = new DatabaseMethods();
    AuthResult result = await auth.createUserWithEmailAndPassword(
        email: email, password: email);
    FirebaseUser user = result.user;
    if (result != null) {
      Map<String, String> userDataMap = {"username": userName, "email": email};
      databaseMethods.addUserInfo(userDataMap);

      HelperFunctions.saveUserLoggedInSharedPreference(true);
      HelperFunctions.saveUserNameSharedPreference(userName);
      HelperFunctions.saveUserEmailSharedPreference(email);
    }

    return Future.value(user);
    // return Future.value(true);
  } catch (error) {
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        showErrDialog(context, "Email Already Exists");
        break;
      case 'ERROR_INVALID_EMAIL':
        showErrDialog(context, "Invalid Email Address");
        break;
      case 'ERROR_WEAK_PASSWORD':
        showErrDialog(context, "Please Choose a stronger password");
        break;
    }
    return Future.value(null);
  }
}

Future<bool> SignUpFacebook() async {
//    2407536649-ZFNGnaMhK7tCHBYL4rQ2SGT9nkuTbnL8g3aJCxq acc token
//    Niz5D73o0BaUMZU4GHHGCTSpJmIoxmoPIITPeuOH46SMO acc token secret
  FacebookLogin facebookLogin = FacebookLogin();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final result = await facebookLogin.logIn(['email']);
  final token = result.accessToken.token;
  final graphResponse = await http.get(
      'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
  print(graphResponse.body);
  var profile = json.decode(graphResponse.body);

  if (result.status == FacebookLoginStatus.loggedIn) {
    final credential = FacebookAuthProvider.getCredential(accessToken: token);
    _auth.signInWithCredential(credential);
    Map<String, String> userDataMap = {
      "username": profile['name'].toString(),
      "email": profile['email'].toString().replaceAll('\u0040', '@')
    };
    databaseMethods.addUserInfo(userDataMap);

    HelperFunctions.saveUserLoggedInSharedPreference(true);
    HelperFunctions.saveUserNameSharedPreference(profile['name'].toString());
    HelperFunctions.saveUserEmailSharedPreference(
        profile['email'].toString().replaceAll('\u0040', '@'));
    return Future.value(true);
  } else {
    return Future.value(null);
  }
}

Future<bool> googleSignUp() async {
  GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = await auth.signInWithCredential(credential);

    FirebaseUser user = await auth.currentUser();

    if (result != null) {
      Map<String, String> userDataMap = {
        "username": user.displayName,
        "email": user.email
      };
      databaseMethods.addUserInfo(userDataMap);

      HelperFunctions.saveUserLoggedInSharedPreference(true);
      HelperFunctions.saveUserNameSharedPreference(user.displayName);
      HelperFunctions.saveUserEmailSharedPreference(user.email);
      return Future.value(true);
    } else {
      return Future.value(null);
    }
  }
}

Future signOutUser() async {
  FirebaseUser user = await auth.currentUser();
  print(user.providerData[1].providerId);
  if (user.providerData[1].providerId == 'google.com') {
    await gooleSignIn.disconnect();
  }
  await auth.signOut();
  HelperFunctions.clearData();
  return Future.value(true);
}

import 'package:barter/event/AuthenticationEvent.dart';
import 'package:barter/handler/helperfunctions.dart';
import 'package:barter/provider/database.dart';
import 'package:barter/repository/authRepository.dart';
import 'package:barter/state/AuthenticationState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationLogic
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationLogic() : super(AuthenticationState.initial());

  @override
  AuthenticationState get initialState => AuthenticationState.initial();
  AuthRepository _repository = new AuthRepository();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is Login) {
      //print("Inside Login"+email+userName+password);
      QuerySnapshot userInfoSnapshot =
          await DatabaseMethods().getUserInfo(event.email);
      HelperFunctions.saveUserLoggedInSharedPreference(true);
      HelperFunctions.saveUserNameSharedPreference(
          userInfoSnapshot.documents[0].data["username"]);
      HelperFunctions.saveUserEmailSharedPreference(
          userInfoSnapshot.documents[0].data["email"]);
      HelperFunctions.myName = userInfoSnapshot.documents[0].data["username"];
      //this.add(Login());
      AuthenticationState ss = generateState(state);
      ss.isLoggedIn = true;
      yield ss;
    } else if (event is Signin) {
      
      _repository
          .signIn(event.email, event.psw, event.context)
          .then((value) async {
        if (value != null) {

          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(event.email);

          await HelperFunctions.saveUserLoggedInSharedPreference(true);
          await HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.documents[0].data["username"]);
          //userName = userInfoSnapshot.documents[0].data["username"];
          //email = userInfoSnapshot.documents[0].data["email"];
          await HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.documents[0].data["email"]);
          HelperFunctions.myName =
              userInfoSnapshot.documents[0].data["username"];
          this.add(Login(email: userInfoSnapshot.documents[0].data["email"]));
          AuthenticationState ss = generateState(state);
          ss.isLoggedIn = true;
        }
      });
    } else if (event is FacebookSignIn) {
      _repository.facebookSignIn().then((value) async {
        if (value != null) {
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(event.email);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.documents[0].data["username"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.documents[0].data["email"]);
          HelperFunctions.myName =
              userInfoSnapshot.documents[0].data["username"];
          this.add(Login());
        }
      });
    } else if (event is GoogleSignIn) {
      _repository.googleSignIn().then((value) async {
        if (value != null) {
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(value);
          print(value);
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.documents[0].data["username"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.documents[0].data["email"]);
          HelperFunctions.myName =
              userInfoSnapshot.documents[0].data["username"];
          print("Hii");
          this.add(Login());
        }
      });
    } else if (event is Signup) {
      //email = event.email;
      //userName = event.username;
      //password = event.psw;
      print(event.email + event.psw + event.username);
      _repository
          .signUp(event.email, event.psw, event.username, event.context)
          .then((value) {
        if (value != null) {
          this.add(Login());
          Navigator.pop(event.context);
        }
      });
    } else if (event is GoogleSignUp || event is FacebookSignUp) {
      if (event is GoogleSignUp) {
        _repository.googleSignUp().then((value) async {
          if (value != null) {
            this.add(Login());
          }
        });
      } else {
        _repository.facebookSignUp().then((value) async {
          if (value != null) {
            this.add(Login());
          }
        });
      }
    } else if (event is Logout) {
      print("logout");
      AuthenticationState ss = generateState(state);
      if (await _repository.signOut()) {
        ss.isLoggedIn = false;
      }

      yield ss;
    }
  }

  AuthenticationState generateState(AuthenticationState state) {
    AuthenticationState ss = AuthenticationState.initial();
    return ss;
  }
}

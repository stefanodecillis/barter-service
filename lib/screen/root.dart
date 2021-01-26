import 'package:barter/event/AuthenticationEvent.dart';
import 'package:barter/handler/coreLogic.dart';
import 'package:barter/handler/helperfunctions.dart';
import 'package:barter/logic/authenticationLogic.dart';
import 'package:barter/screen/authentication/authenticate.dart';
import 'package:barter/screen/home.dart';
import 'package:barter/state/AuthenticationState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool userIsLoggedIn = null;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) async {
      if (value == null) value = false;
      setState(() {
        userIsLoggedIn = value;
      });
      if (value) {
        String email = await HelperFunctions.getUserEmailSharedPreference();
        CoreLogic.instance.authenticationLogic.add(Login(email: email));
      }
    });
  }

  onSignIn() {
    setState(() {
      userIsLoggedIn = true;
    });
    CoreLogic.instance.authenticationLogic.add(Login());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationLogic, AuthenticationState>(
      cubit: CoreLogic.instance.authenticationLogic,
      builder: (context, state) {
        switch (state.isLoggedIn) {
          case true:
            return HomeScreen();
          case false:
            return Authenticate(
              onSignIn: onSignIn,
            );
          default:
            return Authenticate(
              onSignIn: onSignIn, //todo waiting room --> splash screen
            );
        }
      },
    );
  }
}

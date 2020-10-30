import 'package:barter/handler/helperfunctions.dart';
import 'package:barter/screen/authentication/authenticate.dart';
import 'package:barter/screen/home.dart';
import 'package:flutter/cupertino.dart';

class RootPage extends StatefulWidget{
  @override
  _RootPageState createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage>{
  bool userIsLoggedIn = null;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value;
      });
    });
  }

  onSignIn(){
    setState(() {
      userIsLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
   switch(userIsLoggedIn){
     case true:
       return HomeScreen();
     case false:
       return Authenticate(onSignIn: onSignIn,);
     default:
       return Authenticate(onSignIn: onSignIn,);
   }
  }
}
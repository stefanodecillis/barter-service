import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

///access tokens
final String apiKey = "acc_6941c2855e44a64";
final String apiSecret = "2edb128375d04f1086a64d9d9a034909";

///

final mainTheme = HexColor('#EA5455');
final secondTheme = HexColor("#2d4059");
final mainBg = HexColor('#decdc3');
final secondBg = HexColor('#e5e5e5');
final enabledSecondTheme = HexColor("#f3b416");

final kHintTextStyle = TextStyle(
  color: Colors.blueGrey,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFFB2DFDB),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

class CustomTheme {
  static Color colorAccent = Color(0xff007EF4);
  static Color textColor = Color(0xff071930);
}

final List<String> filters = ['vintage', 'near', 'cheap', 'homemade'];

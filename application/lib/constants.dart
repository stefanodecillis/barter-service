import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

final mainTheme = Hexcolor('#EA5455');
final secondTheme = Hexcolor("#2d4059");
final mainBg = Hexcolor('#decdc3');
final secondBg = Hexcolor('#e5e5e5');


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

import 'package:flutter/material.dart';

const Color kCandyPink = Color(0xFFED6E78);
const Color kSuperPink = Color(0xFFD65CAB);
const Color kSuperBlue = Color(0xFF7FACC7);
const Color kEmerald = Color(0xFF7EC885);
const Color kHoneydew = Color(0xFFF1FAEE);
const Color kMazCrayola = Color(0xFFFFCB5C);
const Color kMantee = Color(0xFFA6A6B5);
const Color kSkyCrayola = Color(0xFF66DBE1);
const Color kBgBlue = Color(0xff0e1c36);
const Color kUlMarine = Color(0xFF008891);
const Color kBgBlueDark = Color(0xff090723);

const kTextFieldDecoration = InputDecoration(
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  contentPadding: EdgeInsets.only(left: 30),
);

var kThemeData = ThemeData(
    fontFamily: 'OpenSans',
    textTheme: TextTheme(
      headline1: TextStyle(color: Colors.white),
      headline2: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white),
      headline4: TextStyle(color: Colors.white),
      headline5: TextStyle(color: Colors.white),
      headline6: TextStyle(color: Colors.white),
      bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white),
      subtitle1: TextStyle(color: Colors.white),
      subtitle2: TextStyle(color: Colors.white),
      caption: TextStyle(color: Colors.white),
    ),
    brightness: Brightness.dark);

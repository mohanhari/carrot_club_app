import 'package:flutter/material.dart';

class Themes {
  var defaultTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.deepOrange[300],
    accentColor: Colors.deepOrange[300],
    buttonColor: Colors.deepOrange[300],
    canvasColor: Colors.white,
    fontFamily: 'Montserrat',
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
      body1: TextStyle(fontSize: 16.0, letterSpacing: 0.5),
      body2: TextStyle(fontSize: 20.0, letterSpacing: 0.5, fontWeight: FontWeight.w600),
    ),
  );
  var darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    accentColor: Colors.black,
    buttonColor: Colors.black,
    fontFamily: 'Montserrat',
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
      body1: TextStyle(fontSize: 16.0, letterSpacing: 0.5),
      body2: TextStyle(fontSize: 20.0, letterSpacing: 0.5, fontWeight: FontWeight.w600),
    ),
  );
}
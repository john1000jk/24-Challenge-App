import 'package:flutter/material.dart';

ThemeData AppTheme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    accentColor: Colors.white,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 24,
        fontWeight: FontWeight.w200,
        color: Color.fromRGBO(65, 87, 148, 1.0),
      ),
      headline2: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 40,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      headline3: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      ),
      headline4: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 30,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    ),
  );
}

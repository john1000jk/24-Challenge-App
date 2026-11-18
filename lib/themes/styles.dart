import 'package:flutter/material.dart';

/// The old theme used `accentColor: Colors.white`, which no longer exists.
/// Code that read `AppTheme().accentColor` now uses this constant.
const Color accentColor = Colors.white;

// Text styles were named headline1-4 in older Flutter; they map to
// displayLarge, displayMedium, displaySmall and headlineMedium now.
ThemeData appTheme() {
  return ThemeData(
    useMaterial3: false,
    primarySwatch: Colors.blue,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(secondary: accentColor),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 24,
        fontWeight: FontWeight.w200,
        color: Color.fromRGBO(65, 87, 148, 1.0),
      ),
      displayMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 40,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 30,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    ),
  );
}

import 'package:flutter/material.dart';

class SutraTheme {
  static final primaryColor = Colors.grey.shade900;
  static const primary = Colors.black;

  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(primary: primary),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Exo",
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(primary: primary),
    brightness: Brightness.dark,
    // primaryColorDark: primaryColor,
    scaffoldBackgroundColor: Color(0x1A1A1A),
    fontFamily: "Exo",
  );
}

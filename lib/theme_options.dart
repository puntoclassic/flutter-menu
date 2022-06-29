import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

var splashLogoFontStyle = GoogleFonts.smooch(fontSize: 48, color: Colors.white);

var primaryColorLight = const Color.fromARGB(255, 140, 3, 3);
var secondaryColorLight = Colors.white;

var primaryColorDark = const Color.fromARGB(255, 50, 64, 64);
var secondaryColorDark = Colors.grey[900]!;

var colorSchemeLight =
    ColorScheme.light(secondary: Colors.white, background: primaryColorLight);
var colorSchemeDark = ColorScheme.dark(
    secondary: secondaryColorDark, background: primaryColorDark);

var appLightTheme = ThemeData(
  scaffoldBackgroundColor: colorSchemeLight.background,
  colorScheme: colorSchemeLight,
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.black),
  appBarTheme: AppBarTheme(
    titleTextStyle: const TextStyle(color: Colors.white),
    elevation: 0,
    backgroundColor: colorSchemeLight.background,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  primaryColor: colorSchemeLight.primary,
  textTheme: TextTheme(
    bodyMedium: const TextStyle(color: Colors.black),
    titleMedium: GoogleFonts.smooch(fontSize: 24, color: Colors.white),
  ),
);

var appDarkTheme = ThemeData(
  colorScheme: colorSchemeDark,
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.white),
  scaffoldBackgroundColor: colorSchemeDark.background,
  appBarTheme: AppBarTheme(
    titleTextStyle: const TextStyle(color: Colors.white),
    elevation: 0,
    backgroundColor: colorSchemeDark.background,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  primaryColor: colorSchemeDark.primary,
  textTheme: TextTheme(
    bodyMedium: const TextStyle(color: Colors.white),
    titleMedium: GoogleFonts.smooch(fontSize: 24, color: Colors.white),
  ),
);

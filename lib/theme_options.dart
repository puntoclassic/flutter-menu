import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

var splashLogoFontStyle = GoogleFonts.smooch(fontSize: 48);

var primaryColorLight = const Color.fromARGB(255, 242, 242, 242);
var secondaryColorLight = Colors.white;

var primaryColorDark = Colors.black;
var secondaryColorDark = Colors.grey[900]!;

var colorSchemeLight =
    ColorScheme.light(secondary: Colors.white, background: primaryColorLight);
var colorSchemeDark = ColorScheme.dark(
    secondary: secondaryColorDark, background: primaryColorDark);

var appLightTheme = ThemeData(
  scaffoldBackgroundColor: colorSchemeLight.background,
  colorScheme: colorSchemeLight,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: colorSchemeLight.background,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  primaryColor: colorSchemeLight.primary,
  textTheme: TextTheme(
    bodyMedium: const TextStyle(color: Colors.black),
    titleMedium: GoogleFonts.smooch(fontSize: 24),
  ),
);

var appDarkTheme = ThemeData(
  colorScheme: colorSchemeDark,
  scaffoldBackgroundColor: colorSchemeDark.background,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.light,
    elevation: 0,
    backgroundColor: colorSchemeDark.background,
  ),
  primaryColor: colorSchemeDark.primary,
  textTheme: TextTheme(
    bodyMedium: const TextStyle(color: Colors.white),
    titleSmall: const TextStyle(color: Colors.white),
    titleMedium: GoogleFonts.smooch(fontSize: 24, color: Colors.white),
  ),
);

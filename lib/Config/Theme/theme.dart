import 'package:bloc_online_shop/Config/Theme/Colors/g_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  textTheme: TextTheme(
    bodyMedium:
        GoogleFonts.aladin(fontSize: 18, height: 1.3, color: GColor.black),
    bodyLarge:
        GoogleFonts.aladin(fontSize: 22, height: 1.3, color: GColor.black),
    bodySmall:
        GoogleFonts.aladin(fontSize: 16, height: 1.3, color: GColor.black),
  ),
  colorScheme: const ColorScheme.light(
    primary: GColor.blue,
    onPrimary: GColor.black,
    secondary: GColor.green,
    onSecondary: GColor.black,
    error: GColor.red,
    onError: GColor.white,
    surface: GColor.white,
    onSurface: GColor.black,
  ),
);

final ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  textTheme: TextTheme(
    bodyMedium:
        GoogleFonts.aladin(fontSize: 18, height: 1.3, color: GColor.whiteText),
    bodyLarge:
        GoogleFonts.aladin(fontSize: 22, height: 1.3, color: GColor.whiteText),
    bodySmall:
        GoogleFonts.aladin(fontSize: 16, height: 1.3, color: GColor.whiteText),
  ),
  colorScheme: const ColorScheme.dark(
    primary: GColor.lightBlue,
    onPrimary: GColor.whiteText,
    secondary: GColor.neonGreen,
    onSecondary: GColor.whiteText,
    onSurface: GColor.whiteText,
    error: GColor.red,
    onError: GColor.whiteText,
  ),
);

import 'package:bloc_online_shop/Config/Theme/Colors/g_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final gFontFamily = GoogleFonts.aladin(fontSize: 18, height: 1.3);
final ThemeData lightMode = ThemeData(
  textTheme: TextTheme(
    bodyMedium: gFontFamily,
    bodyLarge: gFontFamily,
    bodySmall: gFontFamily,
  ),
  colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: GColor.blue,
      onPrimary: GColor.black,
      secondary: GColor.green,
      onSecondary: GColor.black,
      error: GColor.red,
      onError: GColor.white,
      surface: GColor.white,
      onSurface: GColor.black),
);

final ThemeData darkMode = ThemeData(
    textTheme: TextTheme(
        bodyMedium: gFontFamily,
        bodyLarge: gFontFamily,
        bodySmall: gFontFamily),
    colorScheme: const ColorScheme.dark(
      primary: GColor.lightBlue,
      onPrimary: GColor.whiteText,
      secondary: GColor.neonGreen,
      onSecondary: GColor.whiteText,
      onSurface: GColor.whiteText,
      error: GColor.red,
      onError: GColor.whiteText,
    ));

import 'package:bloc_online_shop/Config/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightMode) {
    _loadTheme();
  }

  /// تغییر تم و ذخیره در SharedPreferences
  Future<void> toggleTheme() async {
    final isDarkMode = state == darkMode;
    final newTheme = isDarkMode ? lightMode : darkMode;
    emit(newTheme);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', !isDarkMode);
  }

  /// بارگذاری تم ذخیره‌شده از SharedPreferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    emit(isDark ? darkMode : lightMode);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(ThemeData.light()) {
    _loadTheme();
  }

  static final _lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
  );

  static final _darkTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.grey,
    brightness: Brightness.dark,
  );

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('theme'); 

    if (savedTheme != null) {
      emit(savedTheme == 'light' ? _lightTheme : _darkTheme);
    } else {
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      emit(brightness == Brightness.dark ? _darkTheme : _lightTheme);
    }
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = state.brightness == Brightness.dark;
    final newTheme = isDark ? _lightTheme : _darkTheme;
    emit(newTheme);
    await prefs.setString('theme', isDark ? 'light' : 'dark');
  }
}

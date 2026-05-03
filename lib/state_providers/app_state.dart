import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  String sharedText = '';
  ThemeMode themeMode = ThemeMode.light;
  static const _textKey = 'shared_text';
  static const _themeKey = 'theme_mode';

  void updateText(String text) {
    sharedText = text;
    _saveState();
    notifyListeners();
  }

  void toggleTheme(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _saveState();
    notifyListeners();
  }

  Future<void> loadState() async {
    final prefs = await SharedPreferences.getInstance();

    sharedText = prefs.getString(_textKey) ?? '';

    final themeString = prefs.getString(_themeKey);
    if (themeString != null) {
      themeMode = ThemeMode.values.firstWhere(
            (e) => e.toString() == themeString,
        orElse: () => ThemeMode.light,
      );
    }

    notifyListeners();
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_textKey, sharedText);
    await prefs.setString(_themeKey, themeMode.toString());
  }
}
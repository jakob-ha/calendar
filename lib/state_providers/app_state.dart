import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  String sharedText = '';
  final List<String> items = [];
  ThemeMode themeMode = ThemeMode.light;

  void updateText(String text) {
    sharedText = text;
    notifyListeners();
  }

  void addItem(String item) {
    if (item.trim().isEmpty) return;
    items.add(item);
    notifyListeners();
  }

  void removeItem(String item) {
    items.remove(item);
    notifyListeners();
  }

  void toggleTheme(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
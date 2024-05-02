import 'package:flutter/material.dart';

class AppNavbarSelectedIndexProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int i) {
    _selectedIndex = i;
    notifyListeners();
  }
}

class AppThemeModeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}

class EphemeralPlayerSearchProvider extends ChangeNotifier {
  String _searchQuery = "";

  String get searchQuery => _searchQuery;

  set searchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}

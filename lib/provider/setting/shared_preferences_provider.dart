import 'package:flutter/material.dart';
import 'package:resto_app/data/local/shared_preferences_service.dart';

class SharedPreferencesProvider extends ChangeNotifier {

  final SharedPreferencesService _sharedPreferencesService;
  bool _isDarkMode = false;

  SharedPreferencesProvider(this._sharedPreferencesService) {
    _loadThemeMode();
  }

  bool get isDarkMode => _isDarkMode;

  Future<void> _loadThemeMode() async {
    _isDarkMode = await _sharedPreferencesService.getThemeMode();
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _sharedPreferencesService.setThemeMode(_isDarkMode);
    notifyListeners();
  }
}
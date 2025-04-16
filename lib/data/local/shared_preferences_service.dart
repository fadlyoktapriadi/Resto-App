import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesService(this._sharedPreferences);

  static const bool isDarkMode = false;

  Future<bool> getThemeMode() async {
    return _sharedPreferences.getBool('isDarkMode') ?? isDarkMode;
  }

  Future<void> setThemeMode(bool value) async {
    await _sharedPreferences.setBool('isDarkMode', value);
  }
}
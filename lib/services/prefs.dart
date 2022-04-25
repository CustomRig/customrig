import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Future<bool> setString(String key, String value) async {
    final _prefs = await SharedPreferences.getInstance();
    return await _prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key);
  }

  Future<bool> clearPrefs(String key) async {
    final _prefs = await SharedPreferences.getInstance();
    return await _prefs.remove(key);
  }
}

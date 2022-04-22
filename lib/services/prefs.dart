import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Future<bool> setString(String key, String value) async {
    final _prefs = await SharedPreferences.getInstance();
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    String? _string;
    SharedPreferences.getInstance()
        .then((value) => _string = value.getString(key));
    return _string;
  }

  Future<void> clearPrefs(String key) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.remove(key);
  }
}

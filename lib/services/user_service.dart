import 'dart:convert';

import 'package:customrig/global/constants/prefs_string.dart';
import 'package:customrig/model/user.dart';
import 'package:customrig/services/prefs.dart';

class UserService {
  Prefs _prefs = Prefs();

  Future<bool> signOut() async {
    return await _prefs.clearPrefs(kUserKey);
  }

  Future<bool> isUserLoggedIn() async {
    final user = await _prefs.getString(kUserKey);
    return user != null;
  }

  Future<String?> getUserId() async {
    final userJSON = await _prefs.getString(kUserKey);
    try {
      final user = User.fromJson(json.decode(userJSON!));
      return user.id;
    } catch (e) {
      return null;
    }
  }
}

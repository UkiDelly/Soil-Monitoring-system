import 'package:shared_preferences/shared_preferences.dart';

class LoginPreferences {
  static SharedPreferences _preferences = _preferences;

  //key for id
  static const _keyId = "";
  //key for password
  static const _keyPassword = "";

  //create a new instance
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //set user id
  static Future setUserId(String id) async =>
      await _preferences.setString(_keyId, id);
  //get id
  static String? getId() => _preferences.getString(_keyId);

  //set password
  static Future setPassword(String password) async =>
      await _preferences.setString(_keyPassword, password);
  //get password
  static String? getPassword() => _preferences.getString(_keyPassword);
}

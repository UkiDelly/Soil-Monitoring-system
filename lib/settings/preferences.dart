import 'package:shared_preferences/shared_preferences.dart';

class LoginPreferences {
  static SharedPreferences _preferences = _preferences;

  //key for the token
  static const _keyToken = "";
  //key for the user id
  static const _keyUserId = "";
  //create a new instance
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //save tokenId
  static Future saveToken(String token) async =>
      await _preferences.setString(_keyToken, token);
  //get token
  static String? getToken() => _preferences.getString(_keyToken);

  //save user id
  static Future saveUserId(String userId) async =>
      await _preferences.setString(_keyUserId, userId);
  //get user id
  static String? getUserId() => _preferences.getString(_keyUserId);
}

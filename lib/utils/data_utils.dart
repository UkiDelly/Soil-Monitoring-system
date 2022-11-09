import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataUtils {
  const DataUtils._();

  static Future<bool> checkToken(FlutterSecureStorage storage) {
    return storage.containsKey(key: 'token');
  }
}

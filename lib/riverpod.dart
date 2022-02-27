import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenNotifier extends StateNotifier<String> {
  TokenNotifier(String state) : super("0");

  setToken(String token) {
    state = token;
  }
}

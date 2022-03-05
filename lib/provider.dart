import 'package:flutter_riverpod/flutter_riverpod.dart';

//Token
class Token extends StateNotifier<String> {
  Token() : super("0");

  setToken(String token) {
    state = token;
  }
}

final tokenProvider = StateNotifierProvider<Token, String>((ref) => Token());

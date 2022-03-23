import 'package:flutter_riverpod/flutter_riverpod.dart';

final tokenProvider = StateProvider<String>((ref) => "");
final gardenIDProvider = StateProvider<String>((ref) => "");

  setToken(String token) {
    state = token;
  }
}

final tokenProvider = StateNotifierProvider<Token, String>((ref) => Token());

// grdenID
final gardenIdProvider = StateProvider<String>(
  (ref) => "",
);

//user ID
final userIdProvider = StateProvider<String>(
  (ref) => "",
);

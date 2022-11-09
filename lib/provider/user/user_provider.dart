import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:thesis/common/base_api.dart';
import 'package:thesis/models/user/user_login_state.dart';
import 'package:thesis/provider/dio/dio_provider.dart';
import 'package:thesis/provider/secure_storage/secure_storage.dart';
import 'package:thesis/repository/user_repository.dart';

import '../../models/user/user_model.dart';

final userIdProvider = StateProvider<String>((ref) => "");

// final userLoginProvider = FutureProvider.family<UserLoginStateBase, UserModel>((ref, user) async {
//   final url = '$baseUrl/${UserRepo.login}';
//   final dio = ref.watch(dioProvider);

//   Response res = await dio.post(url, data: {c});

//   if (res.statusCode != 200) {
//     return UserLoginError(message: res.statusMessage!);
//   }

//   final token = res.data['data']['authToken'];
//   final storage = ref.watch(secureStorageProvider);
//   await storage.write(key: 'token', value: token);

//   final decodedToken = Jwt.parseJwt(token);
//   ref.read(userIdProvider.notifier).update((state) => decodedToken['_id']);

//   return UserLoginSuccess();
// });

final userLoginProvider =
    StateNotifierProvider.family<UserLoginStateNotifier, UserLoginStateBase, UserModel>(
        (ref, user) {
  final dio = ref.watch(dioProvider);
  final storage = ref.watch(secureStorageProvider);

  return UserLoginStateNotifier(dio, storage, user);
});

class UserLoginStateNotifier extends StateNotifier<UserLoginStateBase> {
  final Dio dio;
  final FlutterSecureStorage storage;
  final UserModel user;
  UserLoginStateNotifier(this.dio, this.storage, this.user) : super(UserLoginLoading());

  void login() async {
    final url = '$baseUrl/${UserRepo.login}';
    Response res =
        await dio.post(url, data: {'username': user.username, 'password': user.password});

    if (res.statusCode != 200) {
      state = UserLoginError(message: "Error in login");
    }
    final token = res.data['data']['authToken'];
    await storage.write(key: 'token', value: token);

    final decodedToken = Jwt.parseJwt(token);
    state = UserLoginSuccess(decodedToken['_id']);
  }
}

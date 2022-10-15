import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:thesis/provider/dio/dio_provider.dart';
import 'package:thesis/provider/secure_storage/secure_storage.dart';

import '../../models/user/user_model.dart';

final userIdProvider = StateProvider<String>((ref) => "");

final userLoginProvider = FutureProvider.family<Map<String, dynamic>, UserModel>((ref, user) async {
  const url = "https://soil-analysis-usls.herokuapp.com/v1/user/login";

  final dio = ref.watch(dioProvider);

  Response res = await dio.post(url, data: {'username': user.username, 'password': user.password});

  if (res.statusCode == 401) {}

  final token = res.data['data']['authToken'];
  final storage = ref.watch(secureStorageProvider);
  storage.write(key: 'token', value: token);

  final decodedToken = Jwt.parseJwt(token);
  ref.read(userIdProvider.notifier).update((state) => decodedToken['_id']);

  print(res.data);

  return res.data;
});

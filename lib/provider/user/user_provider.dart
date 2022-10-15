import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis/provider/dio/dio_provider.dart';

import '../../models/user/user_model.dart';

class UserNotifier extends StateNotifier {
  UserNotifier() : super(null);
}

final userLoginProvider = FutureProvider.family<UserModel, Map<String, dynamic>>((ref, data) async {
  const url = "https://soil-analysis-usls.herokuapp.com/v1/user/login";

  final dio = ref.watch(dioProvider);

  Response res = await dio.post(url, data: data);
});

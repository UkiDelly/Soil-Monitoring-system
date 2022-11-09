// garden list
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis/provider/dio/dio_provider.dart';
import 'package:thesis/provider/user/user_provider.dart';

import '../../common/base_api.dart';
import '../../models/garden.dart';
import '../../repository/garden_repository.dart';

final gardnenListProvider = FutureProvider<List<Garden>>((ref) async {
  final dio = ref.watch(dioProvider);
  // fetch data
  final url = "$baseUrl/${GardenRepo.gardenList}";
  Response response = await dio.get(url);

  List<Garden> gardens = [];

  if (response.statusCode == 200) {
    var item = response.data['data'];
    for (var garden in item) {
      if (garden['createdBy'] == ref.watch(userIdProvider)) {
        gardens.add(Garden.fromJson(garden));

        // gardens.add(Garden.fromJson(garden));
      }
    }
  }

  return gardens;
});

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:thesis/provider/user_id.dart';

import '../models/garden.dart';

// garden id
final gardenIDProvider = StateProvider<String>((ref) => "");

// garden list
final gardnenListProvider = FutureProvider<List<Garden>>((ref) async {
  // fetch data
  const url = "https://soil-analysis-usls.herokuapp.com/v1/garden/list";

  var response = await Dio().get(url);
  // var response = await http.get(Uri.parse(url));

  List<Garden> gardens = [];

  if (response.statusCode == 200) {
    var item = response.data['data'];
    for (var garden in item) {
      if (garden['createdBy'] == ref.watch(userIDProvider)) {
        gardens.add(Garden.fromJson(garden));

        // gardens.add(Garden.fromJson(garden));
      }
    }
  }

  return gardens;
});

class GardenNotifier extends StateNotifier<List<Garden>> {
  GardenNotifier() : super([]);
}

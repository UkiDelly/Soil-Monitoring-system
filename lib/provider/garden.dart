import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:thesis/common/base_api.dart';
import 'package:thesis/provider/user/user_provider.dart';
import 'package:thesis/repository/garden_repository.dart';

import '../models/garden.dart';

// garden id
final gardenIDProvider = StateProvider<String>((ref) => "");



class GardenNotifier extends StateNotifier<List<Garden>> {
  GardenNotifier() : super([]);
}

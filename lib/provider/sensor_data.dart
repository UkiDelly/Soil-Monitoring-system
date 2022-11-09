import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:thesis/provider/garden.dart';
import 'package:thesis/provider/secure_storage/secure_storage.dart';

import '../models/sensor_data.dart';

final sensorProvider = StreamProvider.autoDispose<SensorData>((ref) async* {
  final gardenId = ref.watch(gardenIDProvider);
  final storage = ref.watch(secureStorageProvider);
  final token = await storage.read(key: 'token');
  // fetch data
  final url = "https://soil-analysis-usls.herokuapp.com/v1/sensor/getGardenSensorData/$gardenId";

  var response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
  SensorData sensorData = SensorData.fromRawJson(response.body);

  yield sensorData;
});

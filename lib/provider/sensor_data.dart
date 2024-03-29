import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis/provider/garden.dart';
import 'package:http/http.dart' as http;
import 'package:thesis/provider/token.dart';

import '../models/sensor_data.dart';

final sensorProvider = StreamProvider<SensorData>((ref) async* {
  // fetch data
  final url =
      "https://soil-analysis-usls.herokuapp.com/v1/sensor/getGardenSensorData/${ref.watch(gardenIDProvider)}";

  var response = await http.get(Uri.parse(url),
      headers: {'Authorization': 'Bearer ${ref.watch(tokenProvider)}'});

  SensorData sensorData = SensorData.fromRawJson(response.body);

  yield sensorData;
});

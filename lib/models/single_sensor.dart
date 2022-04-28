import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thesis/models/create_history.dart';

class SingleSensorData {
  final Map<String, double> npk;

  final double temp, ph, humidity, moisture;

  SingleSensorData({
    required this.npk,
    required this.temp,
    required this.ph,
    required this.humidity,
    required this.moisture,
  });
}

class Sensor {
  final token;
  final gardenId;

  String path = '';
  int pages = 1;
  List sensorList = [];
  List<HistoryOfSensorData> histrory = [];

  Sensor({required this.token, required this.gardenId});

  getSensorData(plant) async {
    final url =
        "https://soil-analysis-usls.herokuapp.com/v1/sensor/getGardenSensorData/$gardenId";
    // "http://localhost:3000/sensor/getGardenSensorData/$gardenId";

    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    var item = {};
    if (response.statusCode == 200) {
      item = jsonDecode(response.body);

      pages = item['data'].length;

      for (int i = 0; i < pages; i++) {
        sensorList.add(item['data'][i]);
        histrory.add(HistoryOfSensorData(token: token, gardenId: gardenId));
        histrory[i].createHistory();
      }

      switch (plant) {
        case 'Rice':
          path = "assets/plants/rice.png";
          break;
        case 'Corn':
          path = "assets/plants/corn.png";
          break;
        case 'Cassava':
          path = "assets/plants/cassava.png";
          break;
      }
    }
    return sensorList;
  }
}

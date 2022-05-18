import 'dart:convert';

import 'package:http/http.dart' as http;

//* Model of a single sensor data
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

//* Model for the sensors of a garden
class Sensor {
  final token;
  final gardenId;

  String path = '';
  int pages = 1;
  List sensorList = [];

  Sensor({required this.token, required this.gardenId});

  //* Get all the sensor and sensor data of a garden
  getSensorData(plant) async {
    final url =
        "https://soil-analysis-usls.herokuapp.com/v1/sensor/getGardenSensorData/$gardenId";
    // "http://localhost:3000/sensor/getGardenSensorData/$gardenId";

    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    var item = {};
    if (response.statusCode == 200) {
      item = jsonDecode(response.body);

      // If the data is empty return null
      if (item['data'][0].isEmpty) {
        return null;
      }

      pages = item['data'].length;

      for (int i = 0; i < pages; i++) {
        sensorList.add(item['data'][i]);
      }

      // choose what image for the plant
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

  addSennsor(){
    const _url = "https://soil-analysis-usls.herokuapp.com/v1/sensor/create";
    
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

class Garden {
  List gardenList = [];
  String? userId, token;
  Garden({
    this.userId,
    this.token,
  });

  //* Get the garden list
  getGardenList() async {
    const url = "https://soil-analysis-usls.herokuapp.com/v1/garden/list";
    // "http://localhost:3000/v1/garden/list";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);

      // get the garden list
      List temp = item['data'];

      gardenList.clear();
      //find the garden made by the login user
      for (var item in temp) {
        if (item['createdBy'] == userId) {
          gardenList.add(item);
        }
      }

      return gardenList;
    }
  }

  //* create a new garden
  createGarden(
      {required String name, String? notes, required String plant}) async {
    //
    var body = {
      "name": name,
      "notes": notes!,
      "plant": plant,
    };

    const url = "https://soil-analysis-usls.herokuapp.com/v1/garden/create";
    // "http://localhost:3000/v1/garden/create";
    var response = await http.post(Uri.parse(url),
        body: body, headers: {'Authorization': 'Bearer $token'});

    // get the gardenId from the response
    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);
      String gardenId = item['data']['insertedId'];

      //* create as new sensor
      for (int i = 1; i <= 3; i++) {
        _createSensor(gardenId, i, name: name, notes: notes, plant: plant);
      }
      return true;
    }
    return false;
  }

  _createSensor(String gardenId, int i,
      {required String name, String? notes, required String plant}) async {
    const url = "https://soil-analysis-usls.herokuapp.com/v1/sensor/create";
    // "http://localhost:3000/v1/sensor/create";
    var response = await http.post(Uri.parse(url), body: {
      "name": name + i.toString(),
      "notes": notes,
      "plant": plant,
      "gardenId": gardenId,
    }, headers: {
      'Authorization': 'Bearer $token'
    });

    //* create inital sensor data
    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);

      //* get the sensorId
      String sensorId = item['data']['id'];

      final url =
          "https://soil-analysis-usls.herokuapp.com/v1/sensor/addSensorData/$sensorId";
      response = await http.put(Uri.parse(url),
          headers: {
            'Authorization': "Bearer $token",
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            "nitrogen": 0,
            "phosphorous": 0,
            "potassium": 0,
            "pH": 0,
            "temperature": 0,
            "moisture": 0,
            "humidity": 0
          }));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

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
      List _temp = item['data'];

      gardenList.clear();
      //find the garden made by the login user
      for (var item in _temp) {
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

    const _url = "https://soil-analysis-usls.herokuapp.com/v1/garden/create";
    // "http://localhost:3000/v1/garden/create";
    var response = await http.post(Uri.parse(_url),
        body: body, headers: {'Authorization': 'Bearer $token'});

    // get the gardenId from the response
    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);
      String _gardenId = item['data']['insertedId'];

      //* create as new sensor
      const _url = "https://soil-analysis-usls.herokuapp.com/v1/sensor/create";
      // "http://localhost:3000/v1/sensor/create";
      response = await http.post(Uri.parse(_url), body: {
        "name": name,
        "notes": notes,
        "plant": plant,
        "gardenId": _gardenId,
      }, headers: {
        'Authorization': 'Bearer $token'
      });

      //* create inital sensor data
      if (response.statusCode == 200) {
        item = jsonDecode(response.body);

        //* get the sensorId
        String sensorId = item['data']['id'];

        final _url =
            "https://soil-analysis-usls.herokuapp.com/v1/sensor/addSensorData/$sensorId";
        response = await http.put(Uri.parse(_url),
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
        }

        return false;
      }
      return false;
    }
    return false;
  }
}

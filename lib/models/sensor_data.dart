// To parse this JSON data, do
//
//     final sensorData = sensorDataFromJson(jsonString);

import 'dart:convert';

class SensorData {
  SensorData({
    required this.data,
  });

  final List<List<Datum>> data;

  factory SensorData.fromRawJson(String str) =>
      SensorData.fromJson(json.decode(str));

  factory SensorData.fromJson(Map<String, dynamic> json) => SensorData(
        data: List<List<Datum>>.from(json["data"]
            .map((x) => List<Datum>.from(x.map((x) => Datum.fromJson(x))))),
      );
}

class Datum {
  Datum({
    required this.sensorId,
    required this.nitrogen,
    required this.phosphorous,
    required this.potassium,
    required this.pH,
    required this.temperature,
    required this.moisture,
    required this.humidity,
    required this.createdAt,
  });

  final String sensorId;
  final double nitrogen;
  final double phosphorous;
  final double potassium;
  final double pH;
  final double temperature;
  final double moisture;
  final double humidity;
  final DateTime createdAt;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        sensorId: json["sensorId"],
        nitrogen: json["nitrogen"].toDouble(),
        phosphorous: json["phosphorous"].toDouble(),
        potassium: json["potassium"].toDouble(),
        pH: json["pH"].toDouble(),
        temperature: json["temperature"].toDouble(),
        moisture: json["moisture"].toDouble() * 0.001,
        humidity: json["humidity"].toDouble(),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  @override
  String toString() {
    return "Datum(id: $sensorId, nitrogen: $nitrogen, phosphorous: $phosphorous, potassium: $potassium, pH: $pH, temperature: $temperature, moisture: $moisture, humidity: $humidity, createdAt: $createdAt,)";
  }
}

class SingleSensorData {
  final double n, p, k, ph, temp, moisture, humidity;

  SingleSensorData(
      {required this.n,
      required this.p,
      required this.k,
      required this.ph,
      required this.temp,
      required this.moisture,
      required this.humidity});

  get getNPK => <String, double>{
        "Nitrogen": n,
        "Phosphorous": p,
        "Potassium": k,
      };

  @override
  String toString() {
    return "SingleSensorData(n: $n, p: $p, k: $k, ph: $ph, temperature: $temp, moisture: $moisture, humidity: $humidity)";
  }
}

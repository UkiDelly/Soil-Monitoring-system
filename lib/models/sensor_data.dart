// To parse this JSON data, do
//
//     final sensorData = sensorDataFromJson(jsonString);

import 'dart:convert';

import 'package:thesis/views/Garden%20Detail/Status%20widgets/humidity.dart';
import 'package:thesis/views/Garden%20Detail/Status%20widgets/moisture.dart';
import 'package:thesis/views/Garden%20Detail/Status%20widgets/npk_status.dart';
import 'package:thesis/views/Garden%20Detail/Status%20widgets/ph_level.dart';
import 'package:thesis/views/Garden%20Detail/Status%20widgets/tempurature.dart';

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
}

class SingleSensorData {
  final n, p, k, ph, temp, moisture, humidity;

  SingleSensorData(
      {required this.n,
      required this.p,
      required this.k,
      required this.ph,
      required this.temp,
      required this.moisture,
      required this.humidity});

  NPKstatus npk(double width) {
    return NPKstatus(dataMap: {
      "Nitrogen": n,
      "Phosphorous": p,
      "Potassium": k,
    }, width: width);
  }

  PhLevel pH(double width) {
    return PhLevel(
      ph: ph,
      width: width,
    );
  }

  Temp temperature(double width) {
    return Temp(
      temp: temp,
      width: width,
    );
  }

  MoistureLevel moistureLevel(double width) {
    return MoistureLevel(
      moisture: moisture,
      width: width,
    );
  }

  Humidity humidityLevel(double width) {
    return Humidity(
      humidity: humidity,
      width: width,
    );
  }
}

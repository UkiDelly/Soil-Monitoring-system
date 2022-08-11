// To parse this JSON data, do
//
//     final garden = gardenFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thesis/provider/token.dart';
import 'enum.dart';

Garden gardenFromJson(String str) => Garden.fromJson(json.decode(str));

String gardenToJson(Garden data) => json.encode(data.toJson());

class Garden {
  Garden({
    this.id,
    required this.name,
    this.notes,
    required this.plant,
    this.createdBy,
  });

  final String? id;
  final String name;
  final String? notes;
  final Plant plant;
  final String? createdBy;

  factory Garden.fromJson(Map<String, dynamic> json) => Garden(
        id: json["_id"],
        name: json["name"],
        notes: json["notes"],
        plant: stringToEnum(json["plant"]),
        createdBy: json["createdBy"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "notes": notes,
        "plant": enumToString(plant),
      };

  createGarden() async {
    const url = "https://soil-analysis-usls.herokuapp.com//v1/garden/create";
    final token = tokenProvider;

    var response = await http.post(Uri.parse(url),
        headers: {"Authorization": "Bearer $token"}, body: toJson());
  }
}

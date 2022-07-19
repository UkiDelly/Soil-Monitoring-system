// To parse this JSON data, do
//
//     final garden = gardenFromJson(jsonString);

import 'dart:convert';

import 'package:thesis/models/enum.dart';

class Garden {
  Garden({
    this.id,
    required this.name,
    this.notes,
    required this.plant,
    this.createdBy,
    this.createdAt,
  });

  final id;
  final String name;
  final notes;
  final Plant plant;
  final createdBy;
  final createdAt;

  factory Garden.fromRawJson(str) => Garden.fromJson(str);

  String toRawJson() => json.encode(toJson());

  factory Garden.fromJson(Map<String, dynamic> json) => Garden(
        id: json["_id"],
        name: json["name"],
        notes: json["notes"],
        plant: stringToEnum(json["plant"]),
        createdBy: json["createdBy"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "notes": notes,
        "plant": enumToString(plant),
        "createdBy": createdBy,
        "createdAt": createdAt,
      };
}

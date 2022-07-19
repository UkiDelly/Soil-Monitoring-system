// To parse this JSON data, do
//
//     final garden = gardenFromJson(jsonString);

import 'dart:convert';

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

  final id;
  final String name;
  final notes;
  final Plant plant;
  final createdBy;

  factory Garden.fromJson(Map<String, dynamic> json) => Garden(
        id: json["_id"],
        name: json["name"],
        notes: json["notes"],
        plant: stringToEnum(json["plant"]),
        createdBy: json["createdBy"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "notes": notes,
        "plant": enumToString(plant),
        "createdBy": createdBy,
      };
}

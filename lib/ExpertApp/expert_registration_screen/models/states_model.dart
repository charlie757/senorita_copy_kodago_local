
import 'dart:convert';


class StatesModel {
  int id;
  String name;
  int countryId;

  StatesModel({
    required this.id,
    required this.name,
    required this.countryId,
  });

  factory StatesModel.fromJson(Map<String, dynamic> json) => StatesModel(
    id: json["id"],
    name: json["name"],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_id": countryId,
  };
}

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';



class Country {
  dynamic id;
  dynamic sortname;
  dynamic name;
  dynamic phonecode;

  Country({
    required this.id,
    required this.sortname,
    required this.name,
    required this.phonecode,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    sortname: json["sortname"],
    name: json["name"],
    phonecode: json["phonecode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sortname": sortname,
    "name": name,
    "phonecode": phonecode,
  };
}


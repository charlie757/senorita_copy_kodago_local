// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
import 'dart:convert';

class PhotosList {
  dynamic id;
  dynamic expert_id;
  dynamic banner;

  PhotosList(
    this.id,
    this.expert_id,
    this.banner,
  );
}

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';



class CategoryModel {
  dynamic id;
  dynamic parentCategoryId;
  String name;
  String appImage;
  DateTime createdAt;
  DateTime updatedAt;
  String imageUrl;
  dynamic isSelected;

  CategoryModel({
    required this.id,
    required this.parentCategoryId,
    required this.name,
    required this.appImage,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
     this.isSelected,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    parentCategoryId: json["parent_category_id"],
    name: json["name"],
    appImage: json["app_image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_category_id": parentCategoryId,
    "name": name,
    "app_image": appImage,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "imageUrl": imageUrl,
  };
}


class SubCategoryModel {
  int id;
  String categoryId;
  String name;

  SubCategoryModel({
    required this.id,
    required this.categoryId,
    required this.name,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
  };
}


import 'package:get/get.dart';

class ExpertCategorySubCatModel {
  dynamic success;
  List<Data>? data;
  dynamic baseUrl;
  dynamic message;
  dynamic selectedIndex = -1;
  dynamic selectedCategory = '';
  dynamic selectedList=[];

  ExpertCategorySubCatModel({this.success, this.data, this.baseUrl, this.message});

  ExpertCategorySubCatModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    baseUrl = json['base_url'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['base_url'] = baseUrl;
    data['message'] = message;
    return data;
  }
}

class Data {
  dynamic id;
  dynamic categoryId;
  dynamic name;
  final isSelected=false.obs;
  dynamic iconImage;
  dynamic createdAt;
  dynamic updatedAt;

  Data(
      {this.id,
        this.categoryId,
        this.name,
        this.iconImage,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    iconImage = json['icon_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['icon_image'] = iconImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

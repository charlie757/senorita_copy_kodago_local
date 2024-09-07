import 'package:get/get.dart';

class MergeCategoryModel {
  dynamic success;
  List<Data>? data;
  dynamic baseUrl;
  dynamic message;
  dynamic selectedCategory = [].obs;

  dynamic isOpenSubCategory = 1000.obs;

  MergeCategoryModel({this.success, this.data, this.baseUrl, this.message});

  MergeCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    baseUrl = json['base_url'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  dynamic isSelectedCat = false.obs;
  dynamic selectedSubCat = [].obs;
  // dynamic isShowSubCategory = false.obs;
  dynamic iconImage;
  dynamic createdAt;
  dynamic updatedAt;
  List<Subcategory>? subcategory;

  Data(
      {this.id,
      this.categoryId,
      this.name,
      this.iconImage,
      this.createdAt,
      this.updatedAt,
      this.subcategory});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    iconImage = json['icon_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subcategory'] != null) {
      subcategory = <Subcategory>[];
      json['subcategory'].forEach((v) {
        subcategory!.add(Subcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['icon_image'] = iconImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (subcategory != null) {
      data['subcategory'] = subcategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategory {
  dynamic id;
  dynamic categoryId;
  dynamic subCategoryId;
  dynamic name;
  dynamic isSelectedSubCat = false.obs;
  dynamic selectedSubCategory = [];
  dynamic iconImage;
  dynamic createdAt;
  dynamic updatedAt;

  Subcategory(
      {this.id,
      this.categoryId,
      this.subCategoryId,
      this.name,
      this.iconImage,
      this.createdAt,
      this.updatedAt});

  Subcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    name = json['name'];
    iconImage = json['icon_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['name'] = name;
    data['icon_image'] = iconImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

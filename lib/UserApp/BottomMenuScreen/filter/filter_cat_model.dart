import 'package:get/get.dart';

class FilterCatSubCatModel{
  dynamic catId = ''.obs;
  dynamic categoryName = ''.obs;
  dynamic selectedCat=false.obs;
  dynamic selectedList = [].obs;
  dynamic subCategoryList = FilterSubCat().obs;
  FilterCatSubCatModel({
   required this.catId,
    required this.categoryName,
    required this.subCategoryList
});
}
class FilterSubCat {
  dynamic success;
  dynamic message;
  List<Data>? data;
  dynamic isAllSelected=false;
  dynamic selectedList =[];

  FilterSubCat({this.success, this.message, this.data});

  FilterSubCat.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic categoryId;
  dynamic subCategoryId;
  dynamic isSelected = false;
  dynamic name;
  dynamic iconImage;
  dynamic createdAt;
  dynamic updatedAt;

  Data(
      {this.id,
        this.categoryId,
        this.subCategoryId,
        this.name,
        this.iconImage,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    name = json['name'];
    iconImage = json['icon_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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

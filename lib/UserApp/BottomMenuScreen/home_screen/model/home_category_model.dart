class HomeCategoryModel {
  dynamic success;
  List<Data>? data;
  dynamic baseUrl;
  dynamic message;

  HomeCategoryModel({this.success, this.data, this.baseUrl, this.message});

  HomeCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
    baseUrl = json['base_url'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
  dynamic iconImage;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic imgUrl;

  Data(
      {this.id,
        this.categoryId,
        this.name,
        this.iconImage,
        this.createdAt,
        this.updatedAt,this.imgUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    iconImage = json['app_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imgUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['app_image'] = iconImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['imageUrl'] = imgUrl;
    return data;
  }
}

// class ExpertCategoryModel {
//   dynamic success;
//   dynamic message;
//   List<Data>? data;
//
//   ExpertCategoryModel({this.success, this.message, this.data});
//
//   ExpertCategoryModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add( Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  Map<String, dynamic>();
//     data['success'] = success;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   dynamic id;
//   dynamic parentCategoryId;
//   dynamic name;
//   dynamic appImage;
//   dynamic selectedIndex = -1;
//   dynamic selectedCategory = '';
//   dynamic isFeature;
//   dynamic createdAt;
//   dynamic updatedAt;
//   dynamic imageUrl;
//
//   Data(
//       {this.id,
//         this.parentCategoryId,
//         this.name,
//         this.appImage,
//         this.isFeature,
//         this.createdAt,
//         this.updatedAt,
//         this.imageUrl});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     parentCategoryId = json['parent_category_id'];
//     name = json['name'];
//     appImage = json['app_image'];
//     isFeature = json['is_feature'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     imageUrl = json['imageUrl'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  Map<String, dynamic>();
//     data['id'] = id;
//     data['parent_category_id'] = parentCategoryId;
//     data['name'] = name;
//     data['app_image'] = appImage;
//     data['is_feature'] = isFeature;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['imageUrl'] = imageUrl;
//     return data;
//   }
// }

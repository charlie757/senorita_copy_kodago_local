// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
import 'dart:convert';

class OnlineExpertModel {
  dynamic experience;
  dynamic status;
  dynamic imageUrl;
  dynamic userName;
  dynamic category_id;
  dynamic userId;
  dynamic mobile;
  dynamic categoryName;
  dynamic subCat;
  dynamic offer_count;
  dynamic expertId;
  dynamic address;
  dynamic distance;
  dynamic lat;
  dynamic lng;
  dynamic profileImg;
  dynamic avg_rating;
dynamic offers;
  OnlineExpertModel(
    this.experience,
    this.status,
    this.imageUrl,
    this.userName,
    this.category_id,
    this.userId,
    this.mobile,
    this.categoryName,
    this.subCat,
    this.offer_count,
    this.expertId,
    this.address,
    this.distance,
    this.lat,
    this.lng,
    this.avg_rating,
      this.profileImg,
      this.offers
  );
}

class PopularCategoryModel {
  dynamic imageUrl;
  dynamic categoryName;
  dynamic categoryId;

  PopularCategoryModel(
    this.imageUrl,
    this.categoryName,
    this.categoryId,
  );
}

class GetFeatureOfferModel {
  dynamic id;
  dynamic expert_id;
  dynamic banner;
  dynamic is_feature;
  GetFeatureOfferModel(
    this.id,
    this.expert_id,
    this.banner,
    this.is_feature,
  );
}

class HomeScreenModel {
  dynamic getFeatureOffer;
  dynamic offer_base_url;
  dynamic getFeatureCategoryList;
  dynamic category_base_url;
  dynamic topRatedListing;
  dynamic listing_base_url;
  HomeScreenModel(
    this.getFeatureOffer,
    this.offer_base_url,
    this.getFeatureCategoryList,
    this.category_base_url,
    this.topRatedListing,
    this.listing_base_url,
  );
}

class SingleCategoryModel {
  dynamic experience;
  dynamic status;
  dynamic imageUrl;
  dynamic userName;
  dynamic category_id;
  dynamic userId;
  dynamic mobile;
  dynamic categoryName;
  dynamic offer_count;
  dynamic expertId;
  dynamic address;
  dynamic distance;

  SingleCategoryModel({
    required this.experience,
    required this.status,
    required this.imageUrl,
    required this.userName,
    required this.category_id,
    required this.userId,
    required this.mobile,
    required this.categoryName,
    required this.offer_count,
    required this.expertId,
    required this.address,
    required this.distance,
  });

  factory SingleCategoryModel.fromJson(Map<String, dynamic> json) =>
      SingleCategoryModel(
        experience: json["experience"],
        status: json["status"],
        imageUrl: json["imageUrl"],
        userName: json["userName"],
        category_id: json["category_id"],
        userId: json["userId"],
        mobile: json["mobile"],
        categoryName: json["categoryName"],
        offer_count: json["offer_count"],
        expertId: json["expertId"],
        address: json["address"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "experience": experience,
        "status": status,
        "imageUrl": imageUrl,
        "userName": userName,
        "category_id": category_id,
        "userId": userId,
        "mobile": mobile,
        "categoryName": categoryName,
        "offer_count": offer_count,
        "expertId": expertId,
        "address": address,
        "distance": distance,
      };
}

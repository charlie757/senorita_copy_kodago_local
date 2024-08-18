// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
import 'dart:convert';

class CategoryViewAll {
  dynamic experience;
  dynamic price;
  dynamic imageUrl;
  dynamic userName;
  dynamic categoryName;
  dynamic onlineStatus;

  ///ExpertDetails
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic primaryLanguage;
  dynamic secondaryLanguage;
  dynamic expertise;
  dynamic categoryId;

  CategoryViewAll(
    this.experience,
    this.price,
    this.imageUrl,
    this.userName,
    this.categoryName,
    this.city,
    this.state,
    this.country,
    this.primaryLanguage,
    this.secondaryLanguage,
    this.expertise,
    this.onlineStatus,
      this.categoryId,
  );
}

class AllCategoryModel {
  dynamic imageUrl;
  dynamic categoryName;
  dynamic categoryId;

  AllCategoryModel(
    this.imageUrl,
    this.categoryName,
    this.categoryId,
  );
}

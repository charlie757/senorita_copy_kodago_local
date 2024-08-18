// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
import 'dart:convert';

class OfferList {
  dynamic id;
  dynamic expert_id;
  dynamic banner;

  OfferList(
    this.id,
    this.expert_id,
    this.banner,
  );
}

class SubCategory {
  dynamic subCategoryName;

  SubCategory(
      this.subCategoryName,
      );
}
class PriceList {
  dynamic id;
  dynamic item_name;
  dynamic price;
  dynamic subCategory;
  PriceList(
      this.id,
      this.item_name,
      this.price,
      this.subCategory,
      );
}

class RatingList {
  dynamic id;
  dynamic rating;
  dynamic review;
  dynamic created_at;
  dynamic name;
  RatingList(
      this.id,
      this.rating,
      this.review,
      this.created_at,
      this.name
      );
}



class SpecialOfferModel {
  dynamic success;
  dynamic message;
  List<OffersList>? offersList;
  dynamic baseUrl;

  SpecialOfferModel(
      {this.success, this.message, this.offersList, this.baseUrl});

  SpecialOfferModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['offersList'] != null) {
      offersList = <OffersList>[];
      json['offersList'].forEach((v) {
        offersList!.add( OffersList.fromJson(v));
      });
    }
    baseUrl = json['base_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (offersList != null) {
      data['offersList'] = offersList!.map((v) => v.toJson()).toList();
    }
    data['base_url'] = baseUrl;
    return data;
  }
}

class OffersList {
  dynamic id;
  dynamic expertId;
  dynamic banner;
  dynamic type;
  dynamic startDate;
  dynamic startTime;
  dynamic endDate;
  dynamic endTime;
  dynamic description;
  dynamic categoryId;
  dynamic discountPecent;
  dynamic isFeature;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  OffersList(
      {this.id,
        this.expertId,
        this.banner,
        this.type,
        this.startDate,
        this.startTime,
        this.endDate,
        this.endTime,
        this.description,
        this.categoryId,
        this.discountPecent,
        this.isFeature,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  OffersList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expertId = json['expert_id'];
    banner = json['banner'];
    type = json['type'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    endDate = json['end_date'];
    endTime = json['end_time'];
    description = json['description'];
    categoryId = json['category_id'];
    discountPecent = json['discount_pecent'];
    isFeature = json['is_feature'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['expert_id'] = expertId;
    data['banner'] = banner;
    data['type'] = type;
    data['start_date'] = startDate;
    data['start_time'] = startTime;
    data['end_date'] = endDate;
    data['end_time'] = endTime;
    data['description'] = description;
    data['category_id'] = categoryId;
    data['discount_pecent'] = discountPecent;
    data['is_feature'] = isFeature;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

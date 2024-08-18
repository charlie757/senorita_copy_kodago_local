class HomeUserScreenModel {
  dynamic success;
  Data? data;
  dynamic message;

  HomeUserScreenModel({this.success, this.data, this.message});

  HomeUserScreenModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  List<GetFeatureOffer>? getFeatureOffer;
  dynamic offerBaseUrl;
  List<GetFeatureCategoryList>? getFeatureCategoryList;
  dynamic categoryBaseUrl;
  List<TopRatedListing>? topRatedListing;
  dynamic listingBaseUrl;

  Data(
      {this.getFeatureOffer,
        this.offerBaseUrl,
        this.getFeatureCategoryList,
        this.categoryBaseUrl,
        this.topRatedListing,
        this.listingBaseUrl});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['getFeatureOffer'] != null) {
      getFeatureOffer = <GetFeatureOffer>[];
      json['getFeatureOffer'].forEach((v) {
        getFeatureOffer!.add( GetFeatureOffer.fromJson(v));
      });
    }
    offerBaseUrl = json['offer_base_url'];
    if (json['getFeatureCategoryList'] != null) {
      getFeatureCategoryList = <GetFeatureCategoryList>[];
      json['getFeatureCategoryList'].forEach((v) {
        getFeatureCategoryList!.add( GetFeatureCategoryList.fromJson(v));
      });
    }
    categoryBaseUrl = json['category_base_url'];
    if (json['topRatedListing'] != null) {
      topRatedListing = <TopRatedListing>[];
      json['topRatedListing'].forEach((v) {
        topRatedListing!.add( TopRatedListing.fromJson(v));
      });
    }
    listingBaseUrl = json['listing_base_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (getFeatureOffer != null) {
      data['getFeatureOffer'] =
          getFeatureOffer!.map((v) => v.toJson()).toList();
    }
    data['offer_base_url'] = offerBaseUrl;
    if (getFeatureCategoryList != null) {
      data['getFeatureCategoryList'] =
          getFeatureCategoryList!.map((v) => v.toJson()).toList();
    }
    data['category_base_url'] = categoryBaseUrl;
    if (topRatedListing != null) {
      data['topRatedListing'] =
          topRatedListing!.map((v) => v.toJson()).toList();
    }
    data['listing_base_url'] = listingBaseUrl;
    return data;
  }
}

class GetFeatureOffer {
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
  dynamic createdDate;

  GetFeatureOffer(
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
        this.deletedAt,
        this.createdDate});

  GetFeatureOffer.fromJson(Map<String, dynamic> json) {
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
    createdDate = json['created_date'];
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
    data['created_date'] = createdDate;
    return data;
  }
}

class GetFeatureCategoryList {
  dynamic id;
  dynamic name;
  dynamic appImage;
  dynamic createdDate;

  GetFeatureCategoryList({this.id, this.name, this.appImage, this.createdDate});

  GetFeatureCategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    appImage = json['app_image'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['app_image'] = appImage;
    data['created_date'] = createdDate;
    return data;
  }
}

class TopRatedListing {
  dynamic id;
  dynamic categoryId;
  dynamic userId;
  dynamic status;
  dynamic experience;
  dynamic offerCount;
  dynamic avgRating;
  Category? category;
  List<ExpertSubcats>? expertSubcats;
  List<Offers>? offers;
  User? user;

  TopRatedListing(
      {this.id,
        this.categoryId,
        this.userId,
        this.status,
        this.experience,
        this.offerCount,
        this.avgRating,
        this.category,
        this.expertSubcats,
        this.offers,
        this.user});

  TopRatedListing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    status = json['status'];
    experience = json['experience'];
    offerCount = json['offer_count'];
    avgRating = json['avg_rating'];
    category = json['category'] != null
        ?  Category.fromJson(json['category'])
        : null;
    if (json['expert_subcats'] != null) {
      expertSubcats = <ExpertSubcats>[];
      json['expert_subcats'].forEach((v) {
        expertSubcats!.add( ExpertSubcats.fromJson(v));
      });
    }
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add( Offers.fromJson(v));
      });
    }
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['category_id'] = categoryId;
    data['user_id'] = userId;
    data['status'] = status;
    data['experience'] = experience;
    data['offer_count'] = offerCount;
    data['avg_rating'] = avgRating;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (expertSubcats != null) {
      data['expert_subcats'] =
          expertSubcats!.map((v) => v.toJson()).toList();
    }
    if (offers != null) {
      data['offers'] = offers!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Category {
  dynamic id;
  dynamic name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class ExpertSubcats {
  dynamic name;
  dynamic expertId;

  ExpertSubcats({this.name, this.expertId});

  ExpertSubcats.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    expertId = json['expert_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['expert_id'] = expertId;
    return data;
  }
}

class Offers {
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

  Offers(
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

  Offers.fromJson(Map<String, dynamic> json) {
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

class User {
  dynamic id;
  dynamic name;
  dynamic status;
  dynamic address;
  dynamic userType;
  dynamic isAdmin;
  dynamic email;
  dynamic phonecode;
  dynamic mobile;
  dynamic mobileApi;
  dynamic profilePicture;
  dynamic isVerified;
  dynamic accountStatus;
  dynamic distance;
  dynamic lat;
  dynamic lng;

  User(
      {this.id,
        this.name,
        this.status,
        this.address,
        this.userType,
        this.isAdmin,
        this.email,
        this.phonecode,
        this.mobile,
        this.mobileApi,
        this.profilePicture,
        this.isVerified,
        this.accountStatus,
        this.distance,
        this.lat,
        this.lng});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    address = json['address'];
    userType = json['user_type'];
    isAdmin = json['is_admin'];
    email = json['email'];
    phonecode = json['phonecode'];
    mobile = json['mobile'];
    mobileApi = json['mobile_api'];
    profilePicture = json['profile_picture'];
    isVerified = json['is_verified'];
    accountStatus = json['account_status'];
    distance = json['distance'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['address'] = address;
    data['user_type'] = userType;
    data['is_admin'] = isAdmin;
    data['email'] = email;
    data['phonecode'] = phonecode;
    data['mobile'] = mobile;
    data['mobile_api'] = mobileApi;
    data['profile_picture'] = profilePicture;
    data['is_verified'] = isVerified;
    data['account_status'] = accountStatus;
    data['distance'] = distance;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

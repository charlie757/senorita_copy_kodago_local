class SalonDetailsModel {
  dynamic success;
  Data? data;
  dynamic offerBaseUrl;

  SalonDetailsModel({this.success, this.data, this.offerBaseUrl});

  SalonDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    offerBaseUrl = json['offer_base_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['offer_base_url'] = offerBaseUrl;
    return data;
  }
}

class Data {
  dynamic id;
  dynamic categoryId;
  dynamic userId;
  dynamic status;
  dynamic experience;
  dynamic about;
  dynamic kodagoCardUrl;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic avgRating;
  dynamic reviewCount;
  dynamic myRating;
  dynamic myReview;
  dynamic imageUrl;
  List<Offers>? offers;
  // List<Null>? prices;
  Category? category;
  List<ExpertSubcats>? expertSubcats;
  User? user;

  Data(
      {this.id,
        this.categoryId,
        this.userId,
        this.status,
        this.experience,
        this.about,
        this.kodagoCardUrl,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.avgRating,
        this.reviewCount,
        this.myRating,
        this.myReview,
        this.imageUrl,
        this.offers,
        // this.prices,
        this.category,
        this.expertSubcats,
        this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    status = json['status'];
    experience = json['experience'];
    about = json['about'];
    kodagoCardUrl = json['kodago_card_url'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    avgRating = json['avg_rating'];
    reviewCount = json['review_count'];
    myRating = json['my_rating'];
    myReview = json['my_review'];
    imageUrl = json['image_url'];
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add( Offers.fromJson(v));
      });
    }
    // if (json['prices'] != null) {
    //   prices = <Null>[];
    //   json['prices'].forEach((v) {
    //     prices!.add( Null.fromJson(v));
    //   });
    // }
    category = json['category'] != null
        ?  Category.fromJson(json['category'])
        : null;
    if (json['expert_subcats'] != null) {
      expertSubcats = <ExpertSubcats>[];
      json['expert_subcats'].forEach((v) {
        expertSubcats!.add( ExpertSubcats.fromJson(v));
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
    data['about'] = about;
    data['kodago_card_url'] = kodagoCardUrl;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['avg_rating'] = avgRating;
    data['review_count'] = reviewCount;
    data['my_rating'] = myRating;
    data['my_review'] = myReview;
    data['image_url'] = imageUrl;
    if (offers != null) {
      data['offers'] = offers!.map((v) => v.toJson()).toList();
    }
    // if (this.prices != null) {
    //   data['prices'] = this.prices!.map((v) => v.toJson()).toList();
    // }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (expertSubcats != null) {
      data['expert_subcats'] =
          expertSubcats!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
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
    data['start_date'] = this.startDate;
    data['start_time'] = this.startTime;
    data['end_date'] = this.endDate;
    data['end_time'] = this.endTime;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['discount_pecent'] = this.discountPecent;
    data['is_feature'] = this.isFeature;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ExpertSubcats {
  String? name;
  String? expertId;

  ExpertSubcats({this.name, this.expertId});

  ExpertSubcats.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    expertId = json['expert_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['expert_id'] = this.expertId;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? status;
  String? address;
  String? userType;
  String? isAdmin;
  String? email;
  String? phonecode;
  String? mobile;
  String? mobileApi;
  String? profilePicture;
  String? isVerified;
  String? accountStatus;
  String? distance;
  String? lat;
  String? lng;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['address'] = this.address;
    data['user_type'] = this.userType;
    data['is_admin'] = this.isAdmin;
    data['email'] = this.email;
    data['phonecode'] = this.phonecode;
    data['mobile'] = this.mobile;
    data['mobile_api'] = this.mobileApi;
    data['profile_picture'] = this.profilePicture;
    data['is_verified'] = this.isVerified;
    data['account_status'] = this.accountStatus;
    data['distance'] = this.distance;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

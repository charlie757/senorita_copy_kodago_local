class ProfileModel {
  dynamic success;
  List<ExpertImages>? expertImages;
  Data? data;

  ProfileModel({this.success, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
class ExpertImages {
  dynamic id;
  dynamic userId;
  dynamic image;
  dynamic createdAt;
  dynamic updatedAt;

  ExpertImages(
      {this.id, this.userId, this.image, this.createdAt, this.updatedAt});

  ExpertImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
  dynamic subCatId;

  ExpertSubcats({this.name, this.expertId,this.subCatId});

  ExpertSubcats.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    expertId = json['expert_id'];
    subCatId = json['sub_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['expert_id'] = expertId;
    data['sub_category_id']=subCatId;
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
  dynamic qrCodeImage;
  dynamic wallet;
  dynamic mobile;
  dynamic mobileApi;
  dynamic city;
  dynamic state;
  dynamic lat;
  dynamic lng;
  dynamic profilePicture;
  dynamic isVerified;
  dynamic accountStatus;

  User(
      {this.id,
        this.name,
        this.status,
        this.address,
        this.userType,
        this.isAdmin,
        this.email,
        this.qrCodeImage,
        this.phonecode,
        this.wallet,
        this.mobile,
        this.mobileApi,
        this.city,
        this.state,
        this.lat,
        this.lng,
        this.profilePicture,
        this.isVerified,
        this.accountStatus});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    address = json['address'];
    userType = json['user_type'];
    isAdmin = json['is_admin'];
    qrCodeImage = json['qr_code_image'];
    email = json['email'];
    phonecode = json['phonecode'];
    wallet = json['wallet'];
    mobile = json['mobile'];
    city = json['city'];
    state = json['state'];
    lat = json['lat'];
    lng = json['lng'];
    mobileApi = json['mobile_api'];
    profilePicture = json['profile_picture'];
    isVerified = json['is_verified'];
    accountStatus = json['account_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['address'] = address;
    data['user_type'] = userType;
    data['is_admin'] = isAdmin;
    data['email'] = email;
    data['phonecode'] = phonecode;
    data['qr_code_image'] = qrCodeImage;
    data['wallet'] = wallet;
    data['mobile'] = mobile;
    data['mobile_api'] = mobileApi;
    data['city'] = city;
    data['state'] =state;
    data['lat'] =lat;
     data['lng']=lng;
    data['profile_picture'] = profilePicture;
    data['is_verified'] = isVerified;
    data['account_status'] = accountStatus;
    return data;
  }
}

class SalonsModel {
  dynamic id;
  dynamic categoryId;
  dynamic userId;
  dynamic status;
  dynamic experience;
  dynamic offerCount;
  dynamic avgRating;
  Category? category;
  List<ExpertSubcats>? expertSubcats;
  User? user;

  SalonsModel(
      {this.id,
        this.categoryId,
        this.userId,
        this.status,
        this.experience,
        this.offerCount,
        this.avgRating,
        this.category,
        this.expertSubcats,
        this.user});

  SalonsModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['expert_id'] = expertId;
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

class OtpModel {
  int id;
  String name;
  int status;
  int userType;
  int isAdmin;
  String email;
  dynamic phonecode;
  String mobile;
  String mobileApi;
  String profilePicture;
  DateTime createdAt;
  DateTime updatedAt;
  int wallet;
  String city;
  String state;
  String country;
  int sessionWallet;
  dynamic locationId;
  dynamic birthTime;
  dynamic birthLocation;
  dynamic birthDate;
  dynamic gender;
  String fcmToken;
  String loginToken;
  DateTime emailVerifiedAt;
  dynamic callSid;
  int isVerified;
  int accountStatus;
  ExpertDetails expertDetails;
  dynamic bankdetails;
  Getstate getstate;
  Getcity getcity;
  Getcountry getcountry;

  OtpModel({
    required this.id,
    required this.name,
    required this.status,
    required this.userType,
    required this.isAdmin,
    required this.email,
    required this.phonecode,
    required this.mobile,
    required this.mobileApi,
    required this.profilePicture,
    required this.createdAt,
    required this.updatedAt,
    required this.wallet,
    required this.city,
    required this.state,
    required this.country,
    required this.sessionWallet,
    required this.locationId,
    required this.birthTime,
    required this.birthLocation,
    required this.birthDate,
    required this.gender,
    required this.fcmToken,
    required this.loginToken,
    required this.emailVerifiedAt,
    required this.callSid,
    required this.isVerified,
    required this.accountStatus,
    required this.expertDetails,
    required this.bankdetails,
    required this.getstate,
    required this.getcity,
    required this.getcountry,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    userType: json["user_type"],
    isAdmin: json["is_admin"],
    email: json["email"],
    phonecode: json["phonecode"],
    mobile: json["mobile"],
    mobileApi: json["mobile_api"],
    profilePicture: json["profile_picture"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    wallet: json["wallet"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    sessionWallet: json["session_wallet"],
    locationId: json["location_id"],
    birthTime: json["birth_time"],
    birthLocation: json["birth_location"],
    birthDate: json["birth_date"],
    gender: json["gender"],
    fcmToken: json["fcm_token"],
    loginToken: json["login_token"],
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
    callSid: json["call_sid"],
    isVerified: json["is_verified"],
    accountStatus: json["account_status"],
    expertDetails: ExpertDetails.fromJson(json["expert_details"]),
    bankdetails: json["bankdetails"],
    getstate: Getstate.fromJson(json["getstate"]),
    getcity: Getcity.fromJson(json["getcity"]),
    getcountry: Getcountry.fromJson(json["getcountry"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "user_type": userType,
    "is_admin": isAdmin,
    "email": email,
    "phonecode": phonecode,
    "mobile": mobile,
    "mobile_api": mobileApi,
    "profile_picture": profilePicture,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "wallet": wallet,
    "city": city,
    "state": state,
    "country": country,
    "session_wallet": sessionWallet,
    "location_id": locationId,
    "birth_time": birthTime,
    "birth_location": birthLocation,
    "birth_date": birthDate,
    "gender": gender,
    "fcm_token": fcmToken,
    "login_token": loginToken,
    "email_verified_at": emailVerifiedAt.toIso8601String(),
    "call_sid": callSid,
    "is_verified": isVerified,
    "account_status": accountStatus,
    "expert_details": expertDetails.toJson(),
    "bankdetails": bankdetails,
    "getstate": getstate.toJson(),
    "getcity": getcity.toJson(),
    "getcountry": getcountry.toJson(),
  };
}

class ExpertDetails {
  int id;
  int categoryId;
  int userId;
  int primaryLangId;
  int secondaryLangId;
  int status;
  String experience;
  String bio;
  String expertise;
  dynamic sessions;
  String price;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  Arylanguage primarylanguage;
  Arylanguage secondarylanguage;
  Category category;

  ExpertDetails({
    required this.id,
    required this.categoryId,
    required this.userId,
    required this.primaryLangId,
    required this.secondaryLangId,
    required this.status,
    required this.experience,
    required this.bio,
    required this.expertise,
    required this.sessions,
    required this.price,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.primarylanguage,
    required this.secondarylanguage,
    required this.category,
  });

  factory ExpertDetails.fromJson(Map<String, dynamic> json) => ExpertDetails(
    id: json["id"],
    categoryId: json["category_id"],
    userId: json["user_id"],
    primaryLangId: json["primary_lang_id"],
    secondaryLangId: json["secondary_lang_id"],
    status: json["status"],
    experience: json["experience"],
    bio: json["bio"],
    expertise: json["expertise"],
    sessions: json["sessions"],
    price: json["price"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    primarylanguage: Arylanguage.fromJson(json["primarylanguage"]),
    secondarylanguage: Arylanguage.fromJson(json["secondarylanguage"]),
    category: Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "user_id": userId,
    "primary_lang_id": primaryLangId,
    "secondary_lang_id": secondaryLangId,
    "status": status,
    "experience": experience,
    "bio": bio,
    "expertise": expertise,
    "sessions": sessions,
    "price": price,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "primarylanguage": primarylanguage.toJson(),
    "secondarylanguage": secondarylanguage.toJson(),
    "category": category.toJson(),
  };
}

class Category {
  int id;
  dynamic parentCategoryId;
  String name;
  String appImage;
  DateTime createdAt;
  DateTime updatedAt;

  Category({
    required this.id,
    required this.parentCategoryId,
    required this.name,
    required this.appImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    parentCategoryId: json["parent_category_id"],
    name: json["name"],
    appImage: json["app_image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_category_id": parentCategoryId,
    "name": name,
    "app_image": appImage,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Arylanguage {
  int id;
  String language;
  dynamic createdAt;
  dynamic updatedAt;

  Arylanguage({
    required this.id,
    required this.language,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Arylanguage.fromJson(Map<String, dynamic> json) => Arylanguage(
    id: json["id"],
    language: json["language"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "language": language,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Getcity {
  int id;
  String name;
  int stateId;

  Getcity({
    required this.id,
    required this.name,
    required this.stateId,
  });

  factory Getcity.fromJson(Map<String, dynamic> json) => Getcity(
    id: json["id"],
    name: json["name"],
    stateId: json["state_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state_id": stateId,
  };
}

class Getcountry {
  int id;
  String sortname;
  String name;
  int phonecode;

  Getcountry({
    required this.id,
    required this.sortname,
    required this.name,
    required this.phonecode,
  });

  factory Getcountry.fromJson(Map<String, dynamic> json) => Getcountry(
    id: json["id"],
    sortname: json["sortname"],
    name: json["name"],
    phonecode: json["phonecode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sortname": sortname,
    "name": name,
    "phonecode": phonecode,
  };
}

class Getstate {
  int id;
  String name;
  int countryId;

  Getstate({
    required this.id,
    required this.name,
    required this.countryId,
  });

  factory Getstate.fromJson(Map<String, dynamic> json) => Getstate(
    id: json["id"],
    name: json["name"],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_id": countryId,
  };
}

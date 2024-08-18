class UserProfileModel {
  dynamic success;
  Data? data;
  dynamic message;

  UserProfileModel({this.success, this.data, this.message});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  dynamic name;
  dynamic status;
  dynamic socialId;
  dynamic userType;
  dynamic isAdmin;
  dynamic email;
  dynamic phonecode;
  dynamic mobile;
  dynamic mobileApi;
  dynamic profilePicture;
  dynamic wallet;
  dynamic loginType;
  dynamic city;
  dynamic address;
  dynamic state;
  dynamic referralCode;
  dynamic expertQrCode;
  dynamic country;
  dynamic lat;
  dynamic lng;
  dynamic fcmToken;
  dynamic loginToken;
  dynamic emailVerifiedAt;
  dynamic isVerified;
  dynamic accountStatus;
  dynamic createdAt;
  dynamic updatedAt;

  Data(
      {this.id,
        this.name,
        this.status,
        this.socialId,
        this.userType,
        this.isAdmin,
        this.email,
        this.phonecode,
        this.mobile,
        this.mobileApi,
        this.profilePicture,
        this.wallet,
        this.loginType,
        this.city,
        this.address,
        this.state,
        this.referralCode,
        this.expertQrCode,
        this.country,
        this.lat,
        this.lng,
        this.fcmToken,
        this.loginToken,
        this.emailVerifiedAt,
        this.isVerified,
        this.accountStatus,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    socialId = json['social_id'];
    userType = json['user_type'];
    isAdmin = json['is_admin'];
    email = json['email'];
    phonecode = json['phonecode'];
    mobile = json['mobile'];
    mobileApi = json['mobile_api'];
    profilePicture = json['profile_picture'];
    wallet = json['wallet'];
    loginType = json['login_type'];
    city = json['city'];
    address = json['address'];
    state = json['state'];
    referralCode = json['referral_code'];
    expertQrCode = json['expert_qr_code'];
    country = json['country'];
    lat = json['lat'];
    lng = json['lng'];
    fcmToken = json['fcm_token'];
    loginToken = json['login_token'];
    emailVerifiedAt = json['email_verified_at'];
    isVerified = json['is_verified'];
    accountStatus = json['account_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['social_id'] = socialId;
    data['user_type'] = userType;
    data['is_admin'] = isAdmin;
    data['email'] = email;
    data['phonecode'] = phonecode;
    data['mobile'] = mobile;
    data['mobile_api'] = mobileApi;
    data['profile_picture'] = profilePicture;
    data['wallet'] = wallet;
    data['login_type'] = loginType;
    data['city'] = city;
    data['address'] = address;
    data['state'] = state;
    data['referral_code'] = referralCode;
    data['expert_qr_code'] = expertQrCode;
    data['country'] = country;
    data['lat'] = lat;
    data['lng'] = lng;
    data['fcm_token'] = fcmToken;
    data['login_token'] = loginToken;
    data['email_verified_at'] = emailVerifiedAt;
    data['is_verified'] = isVerified;
    data['account_status'] = accountStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

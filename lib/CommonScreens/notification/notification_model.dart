class NotificationModel {
  dynamic success;
  String? message;
  List<Data>? data;

  NotificationModel({this.success, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic userId;
  dynamic title;
  dynamic description;
  dynamic isRead;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic name;
  dynamic status;
  dynamic socialId;
  dynamic userType;
  dynamic isAdmin;
  dynamic email;
  dynamic phonecode;
  dynamic mobile;
  dynamic mobileApi;
  dynamic password;
  dynamic profilePicture;
  dynamic wallet;
  dynamic city;
  dynamic loginType;
  dynamic address;
  dynamic state;
  dynamic referralCode;
  dynamic expertQrCode;
  dynamic qrCodeImage;
  dynamic country;
  dynamic lat;
  dynamic lng;
  dynamic rememberToken;
  dynamic fcmToken;
  dynamic loginToken;
  dynamic emailVerifiedAt;
  dynamic isVerified;
  dynamic accountStatus;

  Data(
      {this.id,
        this.userId,
        this.title,
        this.description,
        this.isRead,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.status,
        this.socialId,
        this.userType,
        this.isAdmin,
        this.email,
        this.phonecode,
        this.mobile,
        this.mobileApi,
        this.password,
        this.profilePicture,
        this.wallet,
        this.loginType,
        this.city,
        this.address,
        this.state,
        this.referralCode,
        this.expertQrCode,
        this.qrCodeImage,
        this.country,
        this.lat,
        this.lng,
        this.rememberToken,
        this.fcmToken,
        this.loginToken,
        this.emailVerifiedAt,
        this.isVerified,
        this.accountStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    status = json['status'];
    socialId = json['social_id'];
    userType = json['user_type'];
    isAdmin = json['is_admin'];
    email = json['email'];
    phonecode = json['phonecode'];
    mobile = json['mobile'];
    mobileApi = json['mobile_api'];
    password = json['password'];
    profilePicture = json['profile_picture'];
    wallet = json['wallet'];
    loginType = json['login_type'];
    city = json['city'];
    address = json['address'];
    state = json['state'];
    referralCode = json['referral_code'];
    expertQrCode = json['expert_qr_code'];
    qrCodeImage = json['qr_code_image'];
    country = json['country'];
    lat = json['lat'];
    lng = json['lng'];
    rememberToken = json['remember_token'];
    fcmToken = json['fcm_token'];
    loginToken = json['login_token'];
    emailVerifiedAt = json['email_verified_at'];
    isVerified = json['is_verified'];
    accountStatus = json['account_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['description'] = description;
    data['is_read'] = isRead;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['status'] = status;
    data['social_id'] = socialId;
    data['user_type'] = userType;
    data['is_admin'] = isAdmin;
    data['email'] = email;
    data['phonecode'] = phonecode;
    data['mobile'] = mobile;
    data['mobile_api'] = mobileApi;
    data['password'] = password;
    data['profile_picture'] = profilePicture;
    data['wallet'] = wallet;
    data['login_type'] = loginType;
    data['city'] = city;
    data['address'] = address;
    data['state'] = state;
    data['referral_code'] = referralCode;
    data['expert_qr_code'] = expertQrCode;
    data['qr_code_image'] = qrCodeImage;
    data['country'] = country;
    data['lat'] = lat;
    data['lng'] = lng;
    data['remember_token'] = rememberToken;
    data['fcm_token'] = fcmToken;
    data['login_token'] = loginToken;
    data['email_verified_at'] = emailVerifiedAt;
    data['is_verified'] = isVerified;
    data['account_status'] = accountStatus;
    return data;
  }
}

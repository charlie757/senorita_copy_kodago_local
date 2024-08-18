import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:senorita/model/user_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../ScreenRoutes/routes.dart';
import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../../../utils/size_config.dart';
import '../../../../widget/error_box.dart';

class ProfileController extends GetxController {

var model = UserProfileModel().obs;
  @override
  Future<void> onInit() async {
    SizeConfig().init();
    profileApiFunction();
    super.onInit();
  }

  profileApiFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await ApiConstants.getWithToken(url: "${ApiUrls.getProfile}/${prefs.getString("id").toString()}", useAuthToken: true);
    if (response != null && response['success'] == true) {
      print(response['data']);
      model.value = UserProfileModel.fromJson(response);
      // name.value=response['data']['name'].toString() ?? "";
      // email.value=response['data']['email'].toString() ?? "";
      // mobile.value=response['data']['mobile'].toString() ?? "";
      // walletAmount.value = response['data']['wallet']??'';
      // referralCode.value = response['data']['referral_code']??"";
      // profileImg.value = response['data']['profile_picture']??"";
    }
  }

}

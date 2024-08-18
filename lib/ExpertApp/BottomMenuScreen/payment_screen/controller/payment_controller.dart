import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../ScreenRoutes/routes.dart';
import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../../../utils/size_config.dart';
import '../../../../widget/error_box.dart';

class PaymentController extends GetxController {
  final name="".obs;
  final email="".obs;
  final mobile="".obs;
  String id="";// Initialize with your desired upper value
  final amountController = TextEditingController();
  final onChange = false.obs;
  final isVisible = false.obs;
  final addMoneyFormKey = GlobalKey<FormState>();
  final selectedAmount = 0.obs;

  @override
  Future<void> onInit() async {
    SizeConfig().init();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id=prefs.getString("id").toString();
    profileApiFunction();


    super.onInit();
  }

  profileApiFunction() async {
    final response = await ApiConstants.getWithToken(url: ApiUrls.getProfile+"/"+id, useAuthToken: true);
    if (response != null && response['success'] == true) {
      print(response['data']);
      name.value=response['data']['name'].toString() ?? "";
      email.value=response['data']['email'].toString() ?? "";
      mobile.value=response['data']['mobile'].toString() ?? "";
    }
  }

  void resetValues() {
    selectedAmount.value = 0;
    amountController.text = "";
  }
}

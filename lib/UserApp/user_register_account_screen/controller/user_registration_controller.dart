import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../api_config/ApiConstant.dart';
import '../../../api_config/Api_Url.dart';
import '../../../utils/showcircledialogbox.dart';
import '../../../utils/size_config.dart';
import '../../../utils/toast.dart';
import '../../../widget/error_box.dart';
import '../../../widget/success_box.dart';

class UserRegistrationController extends GetxController {
  final fullNameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final referralController =TextEditingController();
  final conformPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final checkBoxValue = false.obs;
  final passwordVisible = true.obs;
  final termsConditionValue = 0.obs;
  final isLoading = false.obs;
  var mobile="";
  var email="";

  @override
  void onInit() {
    SizeConfig().init();
    super.onInit();
  }
  void resetValues() {
    fullNameController.clear();
    emailController.clear();
    numberController.clear();


  }


  signUpApiFunction(BuildContext context) async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    showCircleProgressDialog(context);
    var body = {
      'name': fullNameController.text,
      'email': emailController.text,
      'password': "",
      'confirm_password': '',
      'referral_code':referralController.text,
      'mobile': numberController.text,
      'phonecode': '',
      'terms&conditions': termsConditionValue.toString(),
      'device_token': prefs.getString('fcmToken').toString()
    };
    final response = await ApiConstants.post(body: body, url: ApiUrls.userRegistration);
    if (response != null) {
      if (response['success'] == true) {

        Navigator.of(context).pop();
        Get.toNamed(AppRoutes.otpScreen,arguments:["register",numberController.text.toString(),] );
        //formKey.currentState!.reset();
        //
        // fullNameController.text = "";
        // emailController.text = "";
        // numberController.text = "";
        // resetValues();
       // checkBoxValue.value=false;
      } else {
        Navigator.of(context).pop();
        response['error']['mobile']!=null?
            mobile=response['error']['mobile'][0].toString()
            :response['error']["email"]!=null
            ?email=response['error']["email"][0].toString()
            :const SizedBox();


        showErrorMessageDialog(context,"$mobile$email".toString());

      }
    } else {
      Navigator.of(context).pop();
      print('ese');
    }
  }
}

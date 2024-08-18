import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../ScreenRoutes/routes.dart';
import '../../../api_config/Api_Url.dart';
import '../../../utils/showcircledialogbox.dart';
import '../../../utils/size_config.dart';
import '../../../widget/error_box.dart';

class LoginController extends GetxController {
  final mobileController = TextEditingController();
  final LoginFormKey = GlobalKey<FormState>();

  final checkBoxValue = false.obs;
  final passwordVisible = true.obs;
  final isLoading = false.obs;
  RxBool button1Selected = false.obs;
  RxBool button2Selected = false.obs;

  void selectButton1() {
    button1Selected.value = true;
    button2Selected.value = false;
    print("button1");
  }

  void selectButton2() {
    button1Selected.value = false;
    button2Selected.value = true;
    print("button2");
  }

  @override
  void onInit() {
    SizeConfig().init();
    selectButton1();
    super.onInit();
  }

  void resetValues() {
    mobileController.clear();
    mobileController.text = "";
  }


  loginApiFunction(BuildContext context) async {
    showCircleProgressDialog(context);
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.login));
    request.fields.addAll({
      'mobile': mobileController.text,
    });
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    Navigator.of(context).pop();
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result["success"] == true) {
        Get.toNamed(AppRoutes.otpScreen,arguments: ['login', mobileController.text.toString()]);
        LoginFormKey.currentState?.reset();
        mobileController.text = "";
        resetValues();
        checkBoxValue.value=false;
      } else {
        showErrorMessageDialog(context, result["message"].toString());
      }
    } else {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
    showErrorMessageDialog(context, result["message"].toString());
      print(response.reasonPhrase);
    }
  }
}

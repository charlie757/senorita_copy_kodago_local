import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/size_config.dart';
class ForgotPasswordController extends GetxController {
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final checkBoxValue = false.obs;
  final passwordVisible = true.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    SizeConfig().init();
    super.onInit();
  }

  validation() async {
    if (forgotPasswordFormKey.currentState!.validate()) {
      //loginApiFunction();
    }
  }

 /* void loginApiFunction() async {
    isLoading.value = true;
    var body = json.encode({
      "mobile": '+91${numberController.text}',
      "password": passwordController.text.toString(),
    });
    final response = await ApiConfig.post(
        body: body, url: ApiConfig.loginUrl, useAuthToken: false);
    isLoading.value = false;
    if (response != null && response['success'] == true) {
      EasyLoading.showToast(response['message'].toString(),
          toastPosition: EasyLoadingToastPosition.bottom);
      setAuthToken(response['user']['token']);
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      EasyLoading.showToast(response['message'].toString(),
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }*/
}

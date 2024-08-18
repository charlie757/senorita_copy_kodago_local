import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ScreenRoutes/routes.dart';
import '../../../utils/size_config.dart';
class ChangePasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final conformPasswordController = TextEditingController();
  final changePasswordFormKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  @override
  void onInit() {
    SizeConfig().init();
    super.onInit();
  }

  validation() async {
    if (changePasswordFormKey.currentState!.validate()) {
      //loginApiFunction();
      Get.toNamed(AppRoutes.paymentScreen);
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

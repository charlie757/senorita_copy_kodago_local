import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senorita/CommonScreens/notification/notification_model.dart';
import 'package:senorita/UserApp/BottomMenuScreen/profile_screen/controller/profile_controller.dart';
import 'package:senorita/utils/showcircledialogbox.dart';
import 'package:senorita/utils/utils.dart';

import '../../api_config/ApiConstant.dart';
import '../../api_config/Api_Url.dart';

class NotificationController extends GetxController {
  var model = NotificationModel().obs;
  final route = ''.obs;
  @override
  void onInit() {
    route.value = Get.parameters['route'] ?? "";
    Future.delayed(Duration.zero, () {
      callNotificationApiFunction(Get.parameters['userId'].toString());
    });
    super.onInit();
  }

  callNotificationApiFunction(String id) async {
    showCircleProgressDialog(navigatorKey.currentContext!);
    print('object');
    var body = {'user_id': id};
    print(body);
    final response =
        await ApiConstants.post(url: ApiUrls.notificationUrl, body: body);
    Get.back();
    if (response != null && response['success'] == true) {
      model.value = NotificationModel.fromJson(response);
    }
  }
}

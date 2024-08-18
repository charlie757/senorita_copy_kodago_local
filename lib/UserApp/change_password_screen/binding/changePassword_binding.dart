import 'package:get/get.dart';

import '../controller/changePassword_controller.dart';
class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChangePasswordController());
  }
}

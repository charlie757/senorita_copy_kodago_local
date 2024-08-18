import 'package:get/get.dart';

import '../controller/loginController.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}

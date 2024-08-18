import 'package:get/get.dart';

import '../controller/user_registration_controller.dart';

class UserRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserRegistrationController());
  }
}

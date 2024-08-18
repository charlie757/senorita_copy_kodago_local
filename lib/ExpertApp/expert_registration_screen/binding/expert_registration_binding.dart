import 'package:get/get.dart';

import '../controller/expert_registration_controller.dart';

class ExpertRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ExpertRegistrationController());
  }
}

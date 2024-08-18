import 'package:get/get.dart';

import '../controller/expert_profile_controller.dart';

class ExpertProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ExpertProfileController());
  }
}

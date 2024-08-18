import 'package:get/get.dart';

import '../controller/expert_edit_profile_controller.dart';

class ExpertEditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExpertEditProfileController());
    // Get.put(ExpertEditProfileController());
  }
}

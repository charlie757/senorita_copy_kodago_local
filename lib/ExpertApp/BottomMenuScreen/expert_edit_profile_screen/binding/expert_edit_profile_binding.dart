import 'package:get/get.dart';
import 'package:senorita/CommonScreens/otp_screen/controller/otp_controller.dart';

import '../controller/expert_edit_profile_controller.dart';

class ExpertEditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExpertEditProfileController());
    Get.put(OtpController());
    // Get.put(ExpertEditProfileController());
  }
}

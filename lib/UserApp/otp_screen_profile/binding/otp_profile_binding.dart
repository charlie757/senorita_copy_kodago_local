import 'package:get/get.dart';

import '../controller/otp_profile_controller.dart';

class OtpProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpProfileController());
  }
}

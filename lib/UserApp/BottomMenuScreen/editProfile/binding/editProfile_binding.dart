import 'package:get/get.dart';
import 'package:senorita/CommonScreens/otp_screen/controller/otp_controller.dart';

import '../controller/editProfile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditProfileController());
    Get.put(OtpController());
  }
}

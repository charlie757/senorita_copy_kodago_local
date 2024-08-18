import 'package:get/get.dart';
import 'package:senorita/UserApp/BottomMenuScreen/change_location/change_location_controller.dart';

class ChangeLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangeLocationController());
    // Get.put(EditProfileController());
  }
}

import 'package:get/get.dart';
import 'package:senorita/UserApp/BottomMenuScreen/refer_earn/referearn_controller.dart';

class ReferEarnBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ReferEarnController());
  }
}

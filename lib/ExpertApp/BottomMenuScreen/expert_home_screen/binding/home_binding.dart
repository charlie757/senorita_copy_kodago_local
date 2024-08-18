import 'package:get/get.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_home_screen/controller/expert_home_controller.dart';

import '../../expert_dashboard_screen/controller/dashboard_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ExpertHomeController());
  }
}

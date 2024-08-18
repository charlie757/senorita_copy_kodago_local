import 'package:get/get.dart';

import '../../dashboard_screen/controller/dashboard_controller.dart';
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
  }
}

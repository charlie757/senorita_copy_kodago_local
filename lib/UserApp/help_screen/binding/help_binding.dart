import 'package:get/get.dart';

import '../controller/help_controller.dart';

class helpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(helpController());
  }
}

import 'package:get/get.dart';

import '../controller/salon_details_controller.dart';

class SalonDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SalonDetailController());
  }
}

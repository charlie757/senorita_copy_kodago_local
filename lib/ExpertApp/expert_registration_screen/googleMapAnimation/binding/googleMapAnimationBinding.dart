import 'package:get/get.dart';

import '../controller/googleMapAnimationController.dart';


class GoogleMapAnimationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapAnimationController());
  }
}
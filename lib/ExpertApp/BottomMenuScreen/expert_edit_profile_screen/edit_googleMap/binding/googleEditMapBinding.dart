import 'package:get/get.dart';

import '../controller/googleEditMapController.dart';


class GoogleEditMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapEditController());
  }
}
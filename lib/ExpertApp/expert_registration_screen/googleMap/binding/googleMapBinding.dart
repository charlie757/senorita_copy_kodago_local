import 'package:get/get.dart';

import '../controller/googleMapController.dart';


class GoogleMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapController());
  }
}
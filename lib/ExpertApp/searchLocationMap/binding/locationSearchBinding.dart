import 'package:get/get.dart';

import '../controller/searchLocationController.dart';


class SearchLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchLocationController());
  }
}
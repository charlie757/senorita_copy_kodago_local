import 'package:get/get.dart';

import '../controller/searchEditLocationController.dart';


class SearchEditLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchEditLocationController());
  }
}
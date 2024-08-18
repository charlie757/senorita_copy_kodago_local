import 'package:get/get.dart';

import '../controller/priceListcontroller.dart';


class PriceListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PriceListController());
  }
}
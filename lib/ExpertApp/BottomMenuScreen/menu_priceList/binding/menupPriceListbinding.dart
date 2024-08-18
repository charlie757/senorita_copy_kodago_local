import 'package:get/get.dart';

import '../controller/menuPriceListcontroller.dart';


class MenuPriceListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MenuPriceListController());
  }
}
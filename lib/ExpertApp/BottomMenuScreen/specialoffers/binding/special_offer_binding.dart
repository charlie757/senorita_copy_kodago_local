import 'package:get/get.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/specialoffers/controller/special_offer_controller.dart';

class SpecialOfferBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SpecialOfferController());
  }
}

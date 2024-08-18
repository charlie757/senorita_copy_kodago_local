import 'package:get/get.dart';

import '../controller/expert_wallet_controller.dart';

class ExpertWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExpertWalletController());
    // Get.put(ExpertWalletController());
  }
}

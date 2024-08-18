import 'package:get/get.dart';

import '../controller/expert_qr_controller.dart';

class ExpertQrCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ExpertQRScannerController());
  }
}

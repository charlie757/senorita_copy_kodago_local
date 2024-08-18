import 'package:get/get.dart';

import '../controller/scan_qr_code_controller.dart';

class ScanQrCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScanQrCodeController());
    // Get.put(QRScannerController());
  }
}
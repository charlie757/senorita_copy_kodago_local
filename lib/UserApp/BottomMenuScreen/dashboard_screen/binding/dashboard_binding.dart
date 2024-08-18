import 'package:get/get.dart';
import 'package:senorita/UserApp/BottomMenuScreen/wallet_screen/controller/wallet_controller.dart';
import '../controller/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(DashboardController());
    Get.put( WalletController());
  }
}

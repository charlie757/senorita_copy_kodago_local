import 'package:get/get.dart';
import 'package:senorita/CommonScreens/notification/notification_controller.dart';

class NotificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(NotificationController());
    // TODO: implement dependencies
  }

}
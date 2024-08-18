import 'package:get/get.dart';

import '../controller/terms_condition_controller.dart';

class TermsConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TermsConditionController());
  }
}

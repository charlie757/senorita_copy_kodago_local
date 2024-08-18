import 'package:get/get.dart';

import '../controller/createAccount_type_controller.dart';
class CreateAccountTypeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CreateAccountTypeController());
    // TODO: implement dependencies
  }

}

import 'package:get/get.dart';
class CreateAccountTypeController extends GetxController {

final selected = 0.obs;
  RxBool button1Selected = false.obs;
  RxBool button2Selected = false.obs;

  void selectButton1() {
    button1Selected.value = true;
    button2Selected.value = false;
    print("button1");
  }

  void selectButton2() {
    button1Selected.value = false;
    button2Selected.value = true;
    print("button2");

  }

  @override
  void onInit() {
    super.onInit();
    selectButton1();
  }

}

import 'package:get/get.dart';
import '../controller/single_category_list_controller.dart';
class SingleCategoryListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SingleCategoryListController());
  }
}

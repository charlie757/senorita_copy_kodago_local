import 'package:get/get.dart';

import '../../../utils/size_config.dart';

class TermsConditionController extends GetxController {
  final url = "https://mantratalk.com/contact-us/".obs;
  final isLoading=true.obs;
  final loadingPercentage = 0.obs;
  void changeUrl(String newUrl) {
    url.value = newUrl;
  }
  @override
  void onInit() {
    SizeConfig().init();
    super.onInit();
  }




}

import 'package:get/get.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_profile_screen/model/profile_model.dart';
import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';

class ExpertProfileController extends GetxController {
  // final expertId = ''.obs;
  // String id="";// Initialize with your desired upper value
 var model = ProfileModel().obs;
 final expertPhotoList = [].obs;
  @override
  onInit() async {
    profileApiFunction();
    super.onInit();
  }

  Future profileApiFunction() async {
    final response = await ApiConstants.getWithToken(url: ApiUrls.getExpertProfileDetail, useAuthToken: true);
    if (response != null && response['success'] == true) {
      expertPhotoList.value =response['expert_images']??[];
      model.value = ProfileModel.fromJson(response);
      return response;
      }
  }

}

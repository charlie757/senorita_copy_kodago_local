import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_edit_profile_screen/models/edit_categorymodel.dart';
import 'package:senorita/ScreenRoutes/routes.dart';
import 'package:senorita/UserApp/BottomMenuScreen/profile_screen/controller/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../helper/getText.dart';
import '../../../../utils/color_constant.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../../../utils/size_config.dart';
import '../../../../utils/stringConstants.dart';
import '../../../../utils/toast.dart';
import '../../../../widget/error_box.dart';
import '../../expert_dashboard_screen/controller/dashboard_controller.dart';
import '../../expert_profile_screen/controller/expert_profile_controller.dart';
import '../../specialoffers/model/expert_subcategory_model.dart';

class ExpertEditProfileController extends GetxController {
  final fullNameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  ///Address
  final addressString = "".obs;
  // final cityString = "".obs;
  // final stateString = "".obs;
  final latString = "".obs;
  final lngString = "".obs;

  final chargeController = TextEditingController();
  final bioController = TextEditingController();
  final kodagoCardController = TextEditingController();
  final experienceController = TextEditingController();

  final expController = TextEditingController();

  final aboutUsController = TextEditingController();

  var subCatModel = ExpertSubCategoryModel().obs;
  List selectedSubCatList = [].obs;
  ExpertDashboardController dashboardController = ExpertDashboardController();

  final userFormKey = GlobalKey<FormState>();
  final checkBoxValue = false.obs;
  final passwordVisible = true.obs;
  final termsConditionValue = 0.obs;
  final isLoading = false.obs;
  var mobile = "";
  var email = "";
  final expertProfileImage = "".obs;

  ///Country data
  // RxInt selectedCountryType = (-1).obs;
  // final countryString = "".obs;
  // final allCountryList = [].obs;
  // final countryId = "".obs;

  ///State data
  // RxInt selectedStateType = (-1).obs;
  // final stateId = "".obs;
  // final allStateList = [].obs;

  ///City data
  RxInt selectedCityType = (-1).obs;

  final cityId = "".obs;
  final allCityList = [].obs;
  final selectCityId = "".obs;

  ///Category data
  final selectedCategoryType = 0.obs;
  final categoryString = "".obs;
  final categoryId = "".obs;
  final allCategoryList = [].obs;
  final selectCategoryId = "".obs;

  ///Image Picker
  final imgFile = Rx<File?>(null);
  final imgUrl = ''.obs;

  // search
  final isNotMatchCity = false.obs;
  final searchList = [].obs;
  final dropdownDataList = [].obs;
  final allData = [].obs;
  var isChecked = false.obs;
  String Id = "";
  String expertId = "";
  final oneValue = ''.obs;

  ///DropDown
  final countrySharedPrf = ''.obs;
  String token = "";

  ///SubCategory data
  RxInt selectedSubCategoryType = (-1).obs;
  final subCategoryString = "".obs;
  final subCategoryId = "".obs;
  final subCategoryList = [].obs;
  final subCategoryIdList = [].obs;
  final subCategoryNameList = [].obs;

  final ne = [].obs;

  final subCategoryName = "".obs;
  ExpertProfileController expertProfileController = ExpertProfileController();

  var latDouble = 0.0;
  var lngDouble = 0.0;

  @override
  void onInit() async {
    SizeConfig().init();
    getCategoryApiFunction();
    addressString.value = Get.parameters['address'] ?? 'Current Address';
    // cityString.value = Get.parameters['city'].toString() ?? '';
    cityController.text = Get.parameters['city'] ?? '';
    stateController.text = Get.parameters['state'] ?? "";
    // stateString.value = Get.parameters['state'].toString() ?? '';
    latString.value = Get.parameters['currentLat'].toString() ?? '';
    lngString.value = Get.parameters['currentLong'].toString() ?? '';

    //  showToast(addressString.value);

    if (latString.value != "null" || lngString.value != "null") {
      latDouble = double.parse(latString.value);
      lngDouble = double.parse(lngString.value);
    } else {}
    // getCityApiFunction();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Id = prefs.getString("id").toString();
    expertId = prefs.getString("expert_id").toString();
    token = prefs.getString("token").toString();
    setValues();
    super.onInit();
  }

  // void resetValues() {
  //   fullNameController.clear();
  //   emailController.clear();
  //   numberController.clear();
  //   expController.clear();
  //
  // }

  final profileController = Get.put(ExpertProfileController());
  setValues() {
    if (profileController.model.value != null &&
        profileController.model.value!.data != null &&
        profileController.model.value!.data!.user != null) {
      imgUrl.value =
          profileController.model.value!.data!.user!.profilePicture ?? '';
      fullNameController.text =
          profileController.model.value!.data!.user!.name ?? '';
      numberController.text =
          profileController.model.value!.data!.user!.mobile ?? "";
      emailController.text =
          profileController.model.value!.data!.user!.email ?? "";

      Get.parameters['address'] != null
          ? addressString.value
          : addressString.value =
              profileController.model.value!.data!.user!.address ?? "";
      cityController.text =
          profileController.model.value!.data!.user!.city ?? "";
      stateController.text =
          profileController.model.value!.data!.user!.state ?? "";
      latString.value = profileController.model.value!.data!.user!.lat ?? "";
      lngString.value = profileController.model.value!.data!.user!.lng ?? "";
    }
    if (profileController.model != null &&
        profileController.model.value.data != null &&
        profileController.model.value!.data!.category != null) {
      categoryString.value =
          profileController.model.value!.data!.category!.name.toString();
      selectedCategoryType.value = 0;
      // response['data']['category']!=null?response['data']['category']['id']-1:0;
      categoryId.value =
          profileController.model.value!.data!.category!.id.toString();
      categoryId.value.isNotEmpty
          ? getSubCategoryApiFunction(categoryId.value.toString())
          : null;
    }
    if (profileController.model != null &&
        profileController.model.value.data != null &&
        profileController.model.value!.data!.expertSubcats != null) {
      for (int i = 0;
          i < profileController.model.value!.data!.expertSubcats!.length;
          i++) {
        selectedSubCatList.add({
          'name': profileController.model.value!.data!.expertSubcats![i].name,
          'id': profileController.model.value!.data!.expertSubcats![i].subCatId
              .toString()
        });
      }
    }

    expController.text = profileController.model != null &&
            profileController.model.value!.data != null
        ? profileController.model.value!.data!.experience.toString()
        : "";
    kodagoCardController.text = profileController.model != null &&
            profileController.model.value!.data != null &&
            profileController.model.value!.data!.kodagoCardUrl != null
        ? profileController.model.value!.data!.kodagoCardUrl.toString()
        : "";
    aboutUsController.text = profileController.model != null &&
            profileController.model.value!.data != null
        ? profileController.model.value!.data!.about.toString()
        : "";
  }

  final picker = ImagePicker();

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        elevation: 0,
        context: context,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        builder: (builder) {
          return SizedBox(
            height: 150,
            child: Center(
              child: Card(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))
                    //set border radius more than 50% of height and width to make circle
                    ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                _pickImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                              child: iconcreation(
                                  Icons.camera_alt, Colors.pink, "Camera")),
                          GestureDetector(
                              onTap: () {
                                _pickImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                              child: iconcreation(
                                  Icons.insert_photo, Colors.purple, "Gallery"))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget iconcreation(IconData icon, Color color, String text) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Icon(
            icon,
            size: 29,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        getText(
            title: text,
            size: 14,
            fontFamily: celiaRegular,
            color: ColorConstant.blackColor,
            fontWeight: FontWeight.w500),
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      //imgUrl.value = pickedImage.path;
      imgFile.value = File(pickedImage.path);
      print(imgFile);
    } else {
      showToast("Error No image selected");
    }
  }

  validation() async {
    if (userFormKey.currentState!.validate()) {
      //loginApiFunction();
    }
  }

  submitExpertProfileApi(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showCircleProgressDialog(Get.context!);
    isLoading.value = true;
    var headers = {'Authorization': 'Bearer' + token};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          ApiUrls.updateExpertProfileDetail,
        ));
    // var stringSubCategory=subCategoryIdList.join(",");
    request.fields.addAll({
      'name': fullNameController.text.toString(),
      'mobile': numberController.text.toString(),
      'email': emailController.text.toString(),
      'address': addressString.toString(),
      'city': 'Jaipur',
      'state': 'Rajasthan',
      'lat': latString.toString(),
      'lng': lngString.toString(),
      'category_id': categoryId.toString(),
      'sub_categories': selectedSubCatList.isNotEmpty
          ? selectedSubCatList.map((e) => e['id']).join(',')
          : '',
      'experience': expController.text.toString(),
      'kodago_card_url': kodagoCardController.text.toString(),
      'about': aboutUsController.text.toString(),
      'device_token': prefs.getString('fcmToken').toString(),
    });
    print({
      'name': fullNameController.text.toString(),
      'mobile': numberController.text.toString(),
      'email': emailController.text.toString(),
      'address': addressString.toString(),
      'city': cityController.text,
      'state': stateController.text,
      'lat': latString.toString(),
      'lng': lngString.toString(),
      'category_id': categoryId.toString(),
      'sub_categories': selectedSubCatList.isNotEmpty
          ? selectedSubCatList.map((e) => e['id']).join(',')
          : '',
      'experience': expController.text.toString(),
      'kodago_card_url': kodagoCardController.text.toString(),
      'about': aboutUsController.text.toString(),
      'device_token': prefs.getString('fcmToken').toString(),
    });

    request.headers.addAll(headers);

    if (imgFile.value == null) {
    } else {
      final file = await http.MultipartFile.fromPath(
          'profile_picture', imgFile.value!.path);
      request.files.add(file);
    }
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    log(response.body);
    print("request...${response.request}");
    Get.back();
    if (response.statusCode == 200) {
      isLoading.value = false;
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result["success"] == true) {
        if (result['check_verify'].toString() == '1') {
          Get.toNamed(AppRoutes.otpScreen, arguments: [
            "update",
            numberController.text.toString(),
          ]);
        } else {
          Get.back();
          showToast(result["message"].toString());
        }
        // Get.offAllNamed(AppRoutes.expertDashboardScreen);
      } else {
        showErrorMessageDialog(context, result["message"].toString());
      }
    }
  }

  getCityApiFunction() async {
    final response =
        await ApiConstants.get(url: ApiUrls.cityApiUrl + "/" + "all");
    if (response["success"] == true) {
      if (response['data'] != null) {
        allCityList.value = response['data'];
      }
    }
  }

  getCategoryApiFunction() async {
    final response =
        await ApiConstants.get(url: ApiUrls.expertCategoriesApiUrl);
    if (response["success"] == true) {
      if (response['data'] != null) {
        allCategoryList.value = response['data'];
      }
    }
    //showToast(response["message"]);
  }

  getSubCategoryApiFunction(id) async {
    //showCircleProgressDialog(context);
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiUrls.expertSubCategoriesApiUrl));
    request.fields.addAll({
      'category': id,
    });
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      //   Navigator.of(context).pop();
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result["success"] == true) {
        subCatModel.value = ExpertSubCategoryModel.fromJson(result);
        // subCategoryList.value = result['data'];
      } else {
        // showErrorMessageDialog(result["message"].toString());
      }
    }
  }
}

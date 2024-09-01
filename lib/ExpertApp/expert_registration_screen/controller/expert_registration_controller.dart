import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../api_config/ApiConstant.dart';
import '../../../api_config/Api_Url.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/stringConstants.dart';
import '../../../utils/showcircledialogbox.dart';
import '../../../utils/size_config.dart';
import '../../../widget/error_box.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../BottomMenuScreen/specialoffers/model/expert_subcategory_model.dart';
import '../googleMap/controller/googleMapController.dart';

class ExpertRegistrationController extends GetxController {
  final fullNameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final expController = TextEditingController();
  final aboutUsController = TextEditingController();
  final kodagoCardController = TextEditingController();

  MapController mapController = MapController();

  ///Other Data
  GlobalKey<FormState> expertRegistration = GlobalKey<FormState>();

  final checkBoxValue = false.obs;
  final termsConditionValue = 0.obs;
  final isLoading = false.obs;
  var mobile = "";
  var email = "";

  ///Address
  // final addressString = "".obs;
  // final cityString = "".obs;
  // final stateString = "".obs;
  final latString = "".obs;
  final lngString = "".obs;

  ///Category data
  RxInt selectedCategoryType = (-1).obs;
  final categoryString = "".obs;
  final categoryId = "".obs;
  final allCategoryList = [].obs;

  var subCatModel = ExpertSubCategoryModel().obs;
  List selectedSubCatList = [].obs;
  final ne = [].obs;

  ///Image Picker
  File? imgFile;
  final imgUrl = ''.obs;

  final activegps = true.obs;

  // search
  final isNotMatchCity = false.obs;
  final searchList = [].obs;
  final dropdownDataList = [].obs;
  final allData = [].obs;
  var isChecked = false.obs;

  final oneValue = ''.obs;

  LatLng initialposition = LatLng(-0, -0);
  LatLng changeInitialposition = LatLng(-0, -0);
  List<double> lat = []; // Creating an empty list for latitude values
  List<double> long = []; // Creating an empty list for longitude values
  late GoogleMapController googleMapController;

  var latDouble = 0.0;
  var lngDouble = 0.0;

  File? imageFile;

  @override
  void onInit() {
    SizeConfig().init();
    getCategoryApiFunction();
    super.onInit();
  }

  @override
  void dispose() {
    // STEP 3
    expertRegistration.currentState?.dispose();
    super.dispose();
  }

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
      imgUrl.value = pickedImage.path;
    } else {
      // showToast("Error No image selected");
    }
  }

  void resetValues() {
    fullNameController.clear();
    emailController.clear();
    numberController.clear();
    expController.clear();
    aboutUsController.clear();
  }

  void getUserLocation() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      activegps.value = false;
    } else {
      activegps.value = true;
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      EasyLoading.show(status: "Loading....");
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      initialposition = LatLng(position.latitude, position.longitude);
      print(
          "the latitude is: ${position.longitude} and th longitude is: ${position.longitude} ");
      lat.add(position.longitude);
      long.add(position.longitude);

      latString.value = position.latitude.toString();
      lngString.value = position.longitude.toString();

      // initialposition = LatLng(currentLat.value,currentLong.value);

      // subLocality.value = placemark[0].subLocality.toString();
      addressController.text = placemark[0].street.toString() +
          "," +
          placemark[0].thoroughfare.toString() +
          "," +
          placemark[0].subLocality.toString() +
          "," +
          placemark[0].locality.toString() +
          "," +
          placemark[0].administrativeArea.toString() +
          "," +
          placemark[0].country.toString();
      cityController.text = placemark[0].locality.toString();
      stateController.text = placemark[0].administrativeArea.toString();
      EasyLoading.dismiss();
    }
  }

  submitProfileImageApi(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showCircleProgressDialog(context);
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrls.registerExpert));
    request.fields.addAll({
      'name': fullNameController.text.toString(),
      'mobile': numberController.text.toString(),
      'email': emailController.text.toString(),
      'address': addressController.text,
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
    print({
      'name': fullNameController.text.toString(),
      'mobile': numberController.text.toString(),
      'email': emailController.text.toString(),
      'address': addressController.text,
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
    if (imgUrl.value != "") {
      final file =
          await http.MultipartFile.fromPath('profile_picture', imgUrl.value);
      request.files.add(file);
    } else {}
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print("rese...${response.request}");
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result["success"] == true) {
        Get.toNamed(AppRoutes.otpScreen, arguments: [
          "register",
          numberController.text.toString(),
        ]);
        // formKey.currentState?.reset();
        /*  fullNameController.text = "";
        emailController.text = "";
        numberController.text = "";
        resetValues();
        checkBoxValue.value=false;*/
      } else {
        showErrorMessageDialog(context, result["message"].toString());
      }
    }
  }

  getCategoryApiFunction() async {
    final response =
        await ApiConstants.get(url: ApiUrls.expertCategoriesApiUrl);
    if (response["success"] == true) {
      if (response['data'] != null) {
        allCategoryList.value = response['data'];
        //showToast("Data Load Successfully");
      } else {}
    } else {}
    //showToast(response["message"]);
  }

  getSubCategoryApiFunction(BuildContext context, id) async {
    showCircleProgressDialog(context);
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiUrls.expertSubCategoriesApiUrl));
    request.fields.addAll({
      'category': id,
    });
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result["success"] == true) {
        subCatModel.value = ExpertSubCategoryModel.fromJson(result);
        // subCategoryList.value = result['data'];
      } else {
        showErrorMessageDialog(context, result["message"].toString());
      }
    }
  }
}

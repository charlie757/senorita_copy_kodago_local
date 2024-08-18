import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:senorita/ExpertApp/expert_registration_screen/models/category_model.dart';
import 'package:senorita/UserApp/BottomMenuScreen/all_category_screen/all_category_screen.dart';
import 'package:senorita/UserApp/BottomMenuScreen/all_category_screen/controller/all_category_controller.dart';
import 'package:senorita/UserApp/BottomMenuScreen/wallet_screen/wallet.dart';
import 'package:senorita/model/home_user_screen_model.dart';
import 'package:senorita/model/salon_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../CommonScreens/loginScreen/loginScreen.dart';
import '../../../../ScreenRoutes/routes.dart';
import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../home_screen/homescreen.dart';
import '../../home_screen/model/home_category_model.dart';
import '../../home_screen/model/home_model.dart';
import '../../offers_screen/controller/offers_controller.dart';
import '../../offers_screen/offers_screen.dart';
import '../../profile_screen/controller/profile_controller.dart';
import '../../profile_screen/profile.dart';
import '../../wallet_screen/controller/wallet_controller.dart';

class DashboardController extends GetxController {

 final OffersController offersController = Get.put(OffersController());
 final AllCategoryController categoryListController = Get.put(AllCategoryController());
 final ProfileController profileController = Get.put(ProfileController());

 var categoryModel = HomeCategoryModel().obs;
var homeModel = HomeUserScreenModel().obs;

 ///Dashboard Screen
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final selectIndex=0.obs;
  final name="".obs;
  final email="".obs;
  String Id="";// Initialize with your desired upper value

  // NotificationServices notificationService = NotificationServices();
  ///Home Screen
  RxInt selectedAddressType = (-1).obs;
  //final selectedAddressType=0.obs;
  final selectedCategoryId = "".obs;
  final selectedCityId = "".obs;
  String categoryId = "";
  String profileBack = "";
  String token = "";


  ///loading
  final isOnlineExpertLoading = false.obs;
  final isCityLoading = false.obs;
  final allSelected=false.obs;
  final cityName = "All".obs;
  final categoryList =[].obs;

  ///
 final isSeeMore= false.obs;

  ///Pagination
  final count = 1.obs;
  final preventCall = false.obs;
  final page = 1.obs;
  final hasNextPage = true.obs;
  final isFirstLoadRunning = false.obs;
  final isLoadMoreRunning = false.obs;
  ScrollController? paginationController;
  final perPage = 10.obs;
  final isLoading= false.obs;


  ///City data
  RxInt selectedCityType = (-1).obs;
  final cityString = "".obs;
  final cityId = "".obs;

  ///Country data
  RxInt selectedCountryType = (-1).obs;
  final countryString = "".obs;
  final allCountryList = [].obs;
  final countryId = "".obs;

  ///State data
  RxInt selectedStateType = (-1).obs;
  final stateString = "".obs;
  final stateId = "".obs;
  final allStateList = [].obs;

  final allCity = 0.obs;

  ///loading
  final isCategoryLoading= false.obs;

  ///Category data
  RxInt selectedCategoryType = (-1).obs;
  final categoryString = "".obs;
  // final allCategoryList = [].obs;
  var isChecked = false.obs;
  //var hasOffers=2.obs;


  ///Bottom Nav Bar
  final screens=[
    HomeScreen(),
    OffersScreen(),
    Wallet(),
    // AllCategoryScreen(),
    Profile(),
  ];

  final selectedIndex = 0.obs;
  void changeIndex(int index){
    selectedIndex.value = index;

     if(selectedIndex.value==0)
    {
      Get.find<DashboardController>().onInit();
      Get.find<ProfileController>().onInit();

    }
    else if(selectedIndex.value==1)
    {
      Get.find<OffersController>().onInit();
    }
    else if(selectedIndex.value==2){
       Get.find<WalletController>().onInit();

     }
    else if(selectedIndex.value==3){
       Get.find<ProfileController>().onInit();
     }



  }
 List<double> lat = []; // Creating an empty list for latitude values
 List<double> long = []; // Creating an empty list for longitude values
 late GoogleMapController _mapController;
 GoogleMapController get mapController => _mapController;
 final activegps = true.obs;
 final markerList = [].obs;
 final markerIdList = [].obs;
 final currentLat = 0.0.obs;
 final currentLong = 0.0.obs;
 final subLocality = "".obs;
 final address = "".obs;
 final currentAddress = ''.obs;
 final currentSubLocality = ''.obs;
 final city = "".obs;
 final state = "".obs;


 ///Home Screen Data
final bannerIndex =0.obs;


 @override
  Future<void> onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Id=prefs.getString("id").toString();
    token = prefs.getString("token").toString();
    subLocality.value = prefs.getString('subLocality')??'';
    address.value = prefs.getString('address')??'';
    allHomeScreenApiFunction(prefs.getString('lat').toString(),prefs.getString('long').toString(),'',true);
    getUserLocation(true);
   profileApiFunction();
    categoryApiFunction();
    ///Home Screen
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getUserLocation(bool isCallApi) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
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

     Position position = await Geolocator.getCurrentPosition(
         desiredAccuracy: LocationAccuracy.high);
     List<Placemark> placemark =
     await placemarkFromCoordinates(position.latitude, position.longitude);
     print(
         "the latitude is: ${position.longitude} and th longitude is: ${position.longitude} ");
     lat.add(position.longitude);
     long.add(position.longitude);
     currentLat.value = position.latitude;
     currentLong.value = position.longitude;
     prefs.setString('lat', position.latitude.toString());
     prefs.setString('long', position.longitude.toString());
     subLocality.value = placemark[0].subLocality.toString();
     address.value ="${placemark[0].street.toString()}${placemark[0].thoroughfare.toString().isNotEmpty?", ${placemark[0].thoroughfare.toString()}":''}${placemark[0].subLocality.toString().isNotEmpty?", ${placemark[0].subLocality.toString()}":""}${placemark[0].locality.toString().isNotEmpty?", ${placemark[0].locality.toString()}":""}${placemark[0].administrativeArea.toString().isNotEmpty?", ${placemark[0].administrativeArea.toString()}":""}${placemark[0].country.toString().isNotEmpty?", ${placemark[0].country.toString()}":''}";
      city.value=placemark[0].locality.toString();
     state.value=placemark[0].administrativeArea.toString();
     currentSubLocality.value = placemark[0].subLocality.toString();
     currentAddress.value = "${placemark[0].street.toString()}${placemark[0].thoroughfare.toString().isNotEmpty?", ${placemark[0].thoroughfare.toString()}":''}${placemark[0].subLocality.toString().isNotEmpty?", ${placemark[0].subLocality.toString()}":""}${placemark[0].locality.toString().isNotEmpty?", ${placemark[0].locality.toString()}":""}${placemark[0].administrativeArea.toString().isNotEmpty?", ${placemark[0].administrativeArea.toString()}":""}${placemark[0].country.toString().isNotEmpty?", ${placemark[0].country.toString()}":''}";
     city.value=placemark[0].locality.toString();
     state.value=placemark[0].administrativeArea.toString();
     isCallApi?allHomeScreenApiFunction(currentLat.value.toString(),currentLong.value.toString(),'',false):null;
   }
 }

  allHomeScreenApiFunction(lat,long, String searchValue, bool isShowLoad) async {
    page.value=1;
    isLoading.value = true;
    isShowLoad&&homeModel==null? showCircleProgressDialog(Get.context!):false;
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.homeScreen));
    request.fields.addAll({
      'search': searchValue,
      'lat':lat.toString(),
      'lng': long.toString(),
      'type':"load"
    });
    print({
      'search': searchValue,
      'lat':lat.toString(),
      'lng': long.toString(),
      'type':"load"
    });
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse).timeout(const Duration(seconds: 60));
    log("homescreenrepsonse...${response.body}");
    isShowLoad&&homeModel==null? Get.back():null;
    isLoading.value=false;
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success'] == true && result['success'] != null) {
        homeModel.value = HomeUserScreenModel.fromJson(result);
      }
    }
    else
    {
    }
  }



  categoryApiFunction() async {
    isCategoryLoading.value=true;
    var body = {
      'category':'1'
    };
      final response = await ApiConstants.get(url: ApiUrls.expertCategoriesApiUrl,);
    // categoryModel.value = null;
    if (response != null && response['success'] == true) {
      isCategoryLoading.value =false;
      if (response['data'] != null) {
        categoryModel.value = HomeCategoryModel.fromJson(response);

      }
    }
  }

  profileApiFunction() async {
    final response = await ApiConstants.getWithToken(url: ApiUrls.getProfile+"/"+Id, useAuthToken: true);
    if (response != null && response['success'] == true) {
      name.value=response['data']['name'].toString() ?? "";
      email.value=response['data']['email'].toString() ?? "";
    }
  }
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("isLogin");
    prefs.remove("userIsLogin");
    prefs.remove("expertIsLogin");
    Get.offAllNamed(AppRoutes.loginScreen);
  }

}

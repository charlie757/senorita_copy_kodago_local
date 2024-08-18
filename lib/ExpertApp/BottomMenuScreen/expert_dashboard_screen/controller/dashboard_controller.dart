import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_home_screen/controller/expert_home_controller.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_wallet_screen/controller/expert_wallet_controller.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_wallet_screen/expert_wallet.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/specialoffers/controller/special_offer_controller.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/specialoffers/special_offer_screen.dart';
import 'package:senorita/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../ScreenRoutes/routes.dart';
import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../expert_home_screen/expert_homescreen.dart';
import '../../expert_profile_screen/controller/expert_profile_controller.dart';
import '../../expert_profile_screen/expert_profile.dart';

class ExpertDashboardController extends GetxController {
  final  specialOfferController = Get.put(SpecialOfferController());
  final ExpertWalletController expertWalletController = Get.put(ExpertWalletController());
  final ExpertProfileController expertProfileController = Get.put(ExpertProfileController());
 final selectIndex=0.obs;
 final expertName="".obs;
 final expertProfileImage="".obs;

  var isSwitched = true.obs;

  String Id="";
 String token = "";


 //Home Screen Data
 //var isSwitched = false.obs;
 final allCallData = [].obs;
 final isLoading = false.obs;
 String profile="";
  ///Pagination
  final count = 1.obs;
  final preventCall = false.obs;
  final page = 1.obs;
  final hasNextPage = true.obs;
  final isFirstLoadRunning = false.obs;
  final isLoadMoreRunning = false.obs;
  final perPage = 8.obs;

  ///Transaction List
  final allTransactionList = [].obs;
  final onlineOffline="".obs;

  ///Points
  final totalPoints="".obs;


  ///Detail data
  final status = "".obs;


  ///Bottom Nav Bar
  final screens=[
    const ExpertHomeScreen(),
     SpecialOfferScreen(),
    const ExpertWalletScreen(),
    ExpertProfile(),
  ];

  void toggleSwitch(bool value) {
    isSwitched.value = value;
  }

  final selectedIndex = 0.obs;

  void changeIndex(int index){
    selectedIndex.value = index;
    if(index==0){
      Get.find<ExpertHomeController>().onInit();
    }
    else if(index==1){
      Get.find<SpecialOfferController>().onInit();
    }
   else if(index==2){
      expertWalletController.callApiFunction();
    }
    else if(index==3){
      expertProfileController.profileApiFunction();
    }
  }

  @override
  Future<void> onInit() async {
    // expertProfileController.profileApiFunction();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token").toString();
    super.onInit();

  }
  //
  // onlineStatusFunction() async {
  //   final response = await ApiConstants.getWithToken(url: ApiUrls.getExpertStatus, useAuthToken: true);
  //   if (response != null && response['success'] == true) {
  //     print(response['data']);
  //     status.value=response['data']['status'] ?? "";
  //   }
  // }

  expertUpdateApiFunction(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showCircleProgressDialog(context);
   final response =
   await ApiConstants.getWithToken(url:  ApiUrls.updateExpertStatus, useAuthToken: true);
    Get.back();
    if (response != null && response['success'] == true) {
     response['data'].toString();
     toggleSwitch(response['data']=='Offline'?false:true);
     Get.find<ExpertHomeController>().categoryDetailsFunction(prefs.getString("lat").toString(), prefs.getString("long").toString(), navigatorKey.currentContext!,false);
   }
   else
   {
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

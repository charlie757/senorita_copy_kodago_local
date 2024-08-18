import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../ScreenRoutes/routes.dart';
import '../../../../UserApp/BottomMenuScreen/wallet_screen/model/wallet_model.dart';
import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../../../utils/size_config.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/error_box.dart';
import '../../expert_dashboard_screen/controller/dashboard_controller.dart';
import '../../expert_dashboard_screen/model/transaction_model.dart';
import '../../expert_home_screen/model/expert_home_model.dart';
import '../model/wallet_model.dart';

class ExpertWalletController extends GetxController {
  String token = "";
  final id="".obs;// Initialize with your desired upper value
  var model = WalletModel().obs;
  final isLoading = false.obs;



  @override
  Future<void> onInit() async {
    SizeConfig().init();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token").toString();
    id.value=prefs.getString("id").toString();
    super.onInit();
  }


  callApiFunction()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(Get.find<ExpertDashboardController>().selectedIndex.value==2&&model==null){
      showCircleProgressDialog(navigatorKey.currentContext!);
    }
    var headers = {'Authorization': 'Bearer ${prefs.getString("token").toString()}'};
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.transactionUrl));
    request.fields.addAll({
      'user_id':id.value,
    });
    request.headers.addAll(headers);
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse).timeout(const Duration(seconds: 60));
    log(response.body);
    if(Get.find<ExpertDashboardController>().selectedIndex.value==2&&model==null){
      Get.back();
    }
    // Get.back();
    // allOffersList.clear();
    var dataAll = json.decode(response.body);
    if (response.statusCode == 200) {
      model.value = WalletModel.fromJson(dataAll);
    }
    else
    {
    }

  }

}

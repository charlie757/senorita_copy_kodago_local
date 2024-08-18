import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:senorita/ExpertApp/BottomMenuScreen/specialoffers/model/special_offer_model.dart';
import 'package:senorita/utils/showcircledialogbox.dart';
import 'package:senorita/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../UserApp/salon_details_screen/model/offers_list_model.dart';
import '../../../../api_config/Api_Url.dart';

class SpecialOfferController extends GetxController{

  var specialOfferModel = SpecialOfferModel().obs;

  @override
  void onInit() async {
    allOffersApiFunction();
    super.onInit();
  }
  

  allOffersApiFunction() async {
    specialOfferModel.value==null? showCircleProgressDialog(navigatorKey.currentContext!):null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {'Authorization': 'Bearer ${prefs.getString('token')}'};
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiUrls.expertAllOffer));
    request.fields.addAll({
      'type': "offer",
    });

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    log(response.body);
    specialOfferModel.value==null?Get.back():null;
    final result = json.decode(response.body);
    if (response.statusCode == 200&&result['success'] == true) {
      specialOfferModel.value = SpecialOfferModel.fromJson(result);
    }
    else
    {
    }
  }

}
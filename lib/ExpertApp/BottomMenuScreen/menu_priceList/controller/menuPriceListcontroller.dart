import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:senorita/utils/stringConstants.dart';
import 'package:senorita/utils/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../../../utils/validation.dart';
import '../../../../widget/error_box.dart';

class MenuPriceListController extends GetxController {
  final getPriceList = [].obs;
  final isLoading = false.obs;
  String token = "";
  final expertId = "".obs;

  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token").toString();
getPriceListApiFunction(expertId.value);
    super.onInit();

  }

  void removeItem(int index) {
    getPriceList.removeAt(index);
  }



  getPriceListApiFunction(String expertId) async {
    isLoading.value = true;
    try{
      final result = await InternetAddress.lookup('example.com');
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      {
        getPriceList.clear();
        //showCircleProgressDialog(Get.context!);
        isLoading.value = true;
        var headers = {'Authorization': 'Bearer' + token};
        var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrls.getPriceList));
        request.fields.addAll({
          'expert_id': expertId.toString(),
        });
        print("dgfdb..$expertId");
        request.headers.addAll(headers);
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
        log(response.body);
        isLoading.value = false;
        // getPriceList.clear();
        if (response.statusCode == 200) {
          //Get.back();
          isLoading.value = false;
          final result = jsonDecode(response.body) as Map<String, dynamic>;
          if (result['success'] == true && result['success'] != null) {
            print('object${result['Items']}');
            getPriceList.value = result['Items'];
          }
        }
        else
        {
          isLoading.value = false;
          Get.back();
        }
      }else{
        isLoading.value = false;
        print('object');
        internetSnackbar();
      }
    }
    on SocketException catch(e)
    {
      internetSnackbar();
      print(e);
    }

  }

  removePriceListApiFunction(String itemId) async {
    //isLoading.value = true;
    var headers = {'Authorization': 'Bearer' + token};
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiUrls.removePriceList));
    request.fields.addAll({
      'item_id': itemId.toString(),
    });
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    log(response.body);
  //  getPriceList.clear();
    if (response.statusCode == 200) {
   //   isLoading.value = false;
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result['success'] == true && result['success'] != null) {
        getPriceListApiFunction(expertId.value);
        //getPriceList.removeAt(index);
      }
      else
        {
          showToast(result['message'].toString());
        }
    }
  }

}

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api_config/Api_Url.dart';

class SearchSalonController extends GetxController{
  final searchController = TextEditingController();
  final showPrefix = false.obs;
  final searchList = [].obs;
  final imgBaseUrl = ''.obs;
  final lat = ''.obs;
  final long = ''.obs;
  final isSearch = false.obs;


  @override
  Future<void> onInit() async {
    isSearch.value=false;
    super.onInit();
  }
  allHomeScreenApiFunction( String searchValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lat.value = prefs.getString('lat').toString();
    long.value =prefs.getString('long').toString();
    var headers = {'Authorization': 'Bearer ${prefs.getString("token").toString()}'};
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.homeScreen));
    request.fields.addAll({
      'search': searchValue,
      'lat':prefs.getString('lat').toString(),
      'lng': prefs.getString('long').toString(),
      'type':"load"
    });
    print(request.fields);
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse).timeout(const Duration(seconds: 60));
    log(response.body);
    searchList.clear();
    if (response.statusCode == 200) {
      log(response.body);
      final result = json.decode(response.body);
      if (result['success'] == true && result['success'] != null) {
        for (int i = 0; i < result['data'].length; i++) {
          // bannerList.value =result['data']['getFeatureOffer']??[];
          // offerBaseUrl.value=result['data']['offer_base_url']??'';
          searchList.value=result['data']['topRatedListing'];
          imgBaseUrl.value=result['data']['listing_base_url']??'';
        }
      }
    }
    else
    {
    }
  }

}
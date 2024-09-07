import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:senorita/model/user_special_offer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../home_screen/model/home_model.dart';

class OffersController extends GetxController {
  String token = "";
  final allOffersList = [].obs;

  ///Home Screen

  ///loading
  final isOnlineExpertLoading = false.obs;

  ///Pagination
  final count = 1.obs;
  final preventCall = false.obs;
  final page = 1.obs;
  final hasNextPage = true.obs;
  final isFirstLoadRunning = false.obs;
  final isLoadMoreRunning = false.obs;
  ScrollController? paginationController;
  final perPage = 10.obs;
  final isLoading = false.obs;

  //search
  final searchList = [].obs;
  final isSearch = false.obs;

  final isCategoryLoading = false.obs;
  var savedFilterValues;
  final hasOffer = '1'.obs;
  final latitude = "".obs;
  final longitude = "".obs;
  final category = ''.obs;
  final subCategory = ''.obs;
  final rating = ''.obs;
  final newArrivals = ''.obs;
  final discount = ''.obs;
  final price = ''.obs;
  final distance = ''.obs;
  final selectedCatList = [].obs;
  clearValues() {
    hasOffer.value = '1';
    category.value = '';
    subCategory.value = '';
    rating.value = '';
    newArrivals.value = '';
    discount.value = '';
    price.value = '';
    distance.value = '';
    selectedCatList.clear();
    isFirstLoadRunning.value = false;
    isLoadMoreRunning.value = false;
    savedFilterValues = null;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token").toString();
    latitude.value = prefs.getString("lat").toString();
    longitude.value = prefs.getString("long").toString();
    clearValues();
    allOffersApiFunction(false);
    super.onInit();
  }

  allOffersApiFunction(bool showLoading) async {
    page.value = 1;
    showLoading
        ? showCircleProgressDialog(Get.context!)
        : allOffersList.isEmpty
            ? showCircleProgressDialog(Get.context!)
            : null;
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.getExperts));
    request.fields.addAll({
      'page_numbar': page.value.toString(),
      'city_id': '',
      'has_offer': hasOffer.value,
      'lat': latitude.value.toString(),
      'lng': longitude.value.toString(),
      'category_id': category.value,
      'include_item_prices': price.value,
      'distance_val': distance.value,
      'discount': discount.value,
      'rating_val': rating.value,
      'search_val': '',
      'new_arivals': newArrivals.value,
      'sub_category_id': subCategory.value
    });
    print({
      'page_numbar': page.value.toString(),
      'city_id': '',
      'has_offer': hasOffer.value,
      'lat': latitude.value.toString(),
      'lng': longitude.value.toString(),
      'include_item_prices': price.value,
      'discount': discount.value,
      'category_id': category.value,
      'distance_val': distance.value,
      'rating_val': rating.value,
      'search_val': '',
      'new_arivals': newArrivals.value,
      'sub_category_id': subCategory.value
    });
    request.headers.addAll(headers);
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse)
        .timeout(const Duration(seconds: 60));
    log(response.body);
    showLoading
        ? Get.back()
        : allOffersList.isEmpty
            ? Get.back()
            : null;
    isLoading.value = false;
    allOffersList.clear();
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success'] == true && result['success'] != null) {
        for (int i = 0; i < result['data'].length; i++) {
          UserSpecialOfferModel model =
              UserSpecialOfferModel.fromJson(result['data'][i]);
          allOffersList.add(model);
        }
        count.value = result['total_count'];
      }
    } else {}
  }

  allOffersPaginationApiFunction() async {
    if (isLoadMoreRunning.value == false) {
      if (hasNextPage.value == true &&
          isFirstLoadRunning.value == false &&
          isLoadMoreRunning.value == false) {
        if (count.value > allOffersList.length) {
          ++page.value;
          isLoadMoreRunning.value = true;
          var headers = {'Authorization': 'Bearer $token'};
          var request =
              http.MultipartRequest('POST', Uri.parse(ApiUrls.getExperts));
          // if (selectedCategoryId != "") {
          request.fields.addAll({
            'page_numbar': page.value.toString(),
            'city_id': '',
            'has_offer': hasOffer.value,
            'lat': latitude.value.toString(),
            'lng': longitude.value.toString(),
            'category_id': category.value,
            'include_item_prices': price.value,
            'discount': discount.value,
            'distance_val': distance.value,
            'rating_val': rating.value,
            'search_val': '',
            'new_arivals': newArrivals.value,
            'sub_category_id': subCategory.value
          });
          request.headers.addAll(headers);
          var streamedResponse = await request.send();
          var response = await http.Response.fromStream(streamedResponse);
          if (response.statusCode == 200) {
            final result = json.decode(response.body);
            if (result['success'] == true && result['success'] != null) {
              List list = [];
              for (int i = 0; i < result['data'].length; i++) {
                UserSpecialOfferModel model =
                    UserSpecialOfferModel.fromJson(result['data'][i]);
                list.add(model);
              }
              allOffersList.value = allOffersList.value + list;
              isLoadMoreRunning.value = false;
            }
          }
        }
      }
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:senorita/helper/getText.dart';
import 'package:senorita/model/user_special_offer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../api_config/Api_Url.dart';
import 'package:http/http.dart' as http;

class SingleCategoryListController extends GetxController {
  final categoryName = "".obs;
  final shortByList = [].obs;
  final allCategoryList = [].obs;

  final startPointPrice = 0.0.obs;
  final endPointPrice = 70.0.obs;

  final filterButton = false.obs;
  final filterButton1 = false.obs;

  //search
  final searchList = [].obs;
  final isSearch = false.obs;

  ///Pagination
  final count = 1.obs;
  final preventCall = false.obs;
  final page = 1.obs;
  final hasNextPage = true.obs;
  final isFirstLoadRunning = false.obs;
  final isLoadMoreRunning = false.obs;
  final perPage = 10.obs;
  final isLoading = false.obs;
  String token = "";

  final filterUiChange = "0".obs;
  RxInt selectedFilterType = (0).obs;

  final lowerValue = 50.obs;
  final upperValue = 180.obs;

  final locationResult = "0".obs;

  final selectedCategoryId = "".obs;

  final latitude = "".obs;
  final longitude = "".obs;

  ///
  var savedFilterValues;
  final hasOffer = '2'.obs;
  final category = ''.obs;
  final subCategory = ''.obs;
  final rating = ''.obs;
  final newArrivals = ''.obs;
  final discount = ''.obs;
  final price = ''.obs;
  final distance = ''.obs;
  clearValues() {
    hasOffer.value = '2';
    subCategory.value = '';
    rating.value = '';
    newArrivals.value = '';
    discount.value = '';
    price.value = '';
    distance.value = '';
  }

  @override
  Future<void> onInit() async {
    //categoryName=Get.arguments[1];
    if (Get.arguments[1] != null) {
      categoryName.value = Get.arguments[1];
    } else {
      categoryName.value = "";
    }
    if (Get.arguments[0] != null) {
      category.value = Get.arguments[0];
    } else {
      category.value = "";
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token").toString();
    latitude.value = prefs.getString("lat").toString();
    longitude.value = prefs.getString("long").toString();
    clearValues();
    allCategoryApiFunction();
    super.onInit();
  }

  allCategoryApiFunction() async {
    page.value = 1;
    // showCircleProgressDialog(Get.context!);
    isLoading.value = true;
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.getExperts));

    request.fields.addAll({
      'page_numbar': page.value.toString(),
      'has_offer': '2',
      'lat': latitude.value.toString(),
      'lng': longitude.value.toString(),
      'category_id': category.value,
      'include_item_prices': price.value,
      'sub_category_id': subCategory.value,
      'new_arivals': newArrivals.value,
      'distance_val': distance.value,
      'rating_val': rating.value,
      'discount': discount.value,
      'search_val': '',
    });
    print({
      'page_numbar': page.value.toString(),
      'has_offer': '2',
      'lat': latitude.value.toString(),
      'lng': longitude.value.toString(),
      'category_id': category.value,
      'include_item_prices': price.value,
      'sub_category_id': subCategory.value,
      'new_arivals': newArrivals.value,
      'distance_val': distance.value,
      'rating_val': rating.value,
      'discount': discount.value,
      'search_val': '',
    });
    request.headers.addAll(headers);
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse)
        .timeout(const Duration(seconds: 60));
    log(response.body);
    //  Get.back();
    isLoading.value = false;
    allCategoryList.clear();
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result['success'] == true && result['success'] != null) {
        for (int i = 0; i < result['data'].length; i++) {
          UserSpecialOfferModel model =
              UserSpecialOfferModel.fromJson(result['data'][i]);
          allCategoryList.add(model);
        }
        count.value = result['total_count'];
      }
    } else {}
  }

  allCategoryPaginationApiFunction() async {
    if (isLoadMoreRunning.value == false) {
      if (hasNextPage.value == true &&
          isFirstLoadRunning.value == false &&
          isLoadMoreRunning.value == false) {
        if (count.value > allCategoryList.length) {
          ++page.value;
          isLoadMoreRunning.value = true;
          var headers = {'Authorization': 'Bearer $token'};
          var request =
              http.MultipartRequest('POST', Uri.parse(ApiUrls.getExperts));
          request.fields.addAll({
            'page_numbar': page.value.toString(),
            'has_offer': '2',
            'lat': latitude.value.toString(),
            'lng': longitude.value.toString(),
            'category_id': category.value,
            'include_item_prices': price.value,
            'sub_category_id': subCategory.value,
            'new_arivals': newArrivals.value,
            'distance_val': distance.value,
            'rating_val': rating.value,
            'discount': discount.value,
            'search_val': '',
          });
          request.headers.addAll(headers);
          var streamedResponse = await request.send();
          var response = await http.Response.fromStream(streamedResponse);
          log(response.body);
          if (response.statusCode == 200) {
            final result = json.decode(response.body);
            if (result['success'] == true && result['success'] != null) {
              List list = [];
              for (int i = 0; i < result['data'].length; i++) {
                UserSpecialOfferModel model =
                    UserSpecialOfferModel.fromJson(result['data'][i]);
                list.add(model);
              }
              allCategoryList.value = allCategoryList.value + list;
              isLoadMoreRunning.value = false;
            }
          }
        }
      }
    }
  }
}

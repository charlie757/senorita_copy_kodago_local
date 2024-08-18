import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../home_screen/model/home_model.dart';

class  AllCategoryController extends GetxController {
  final categoryList =[].obs;
  final isCategoryLoading= false.obs;

  @override
  Future<void> onInit() async {
    categoryApiFunction();

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  categoryApiFunction() async {
    categoryList.clear();
    isCategoryLoading.value=true;
    final response = await ApiConstants.getWithToken(url: ApiUrls.expertCategoriesApiUrl, useAuthToken: true);
    if (response != null && response['success'] == true) {
      isCategoryLoading.value =false;
      if (response['data'] != null) {
        for (int i = 0; i < response['data'].length; i++) {
          print(response['data'],);
          PopularCategoryModel model = PopularCategoryModel(
              response['data'][i]['imageUrl'].toString(),
              response['data'][i]['name'].toString(),
              response['data'][i]['id'].toString());
          categoryList.add(model);
        }

      }
    }
  }
}

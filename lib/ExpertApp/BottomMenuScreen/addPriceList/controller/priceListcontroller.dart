import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:senorita/ScreenRoutes/routes.dart';
import 'package:senorita/utils/stringConstants.dart';
import 'package:senorita/utils/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/error_box.dart';
import '../../expert_profile_screen/controller/expert_profile_controller.dart';
import '../../specialoffers/controller/add_offer_controller.dart';
import '../../specialoffers/model/expert_category_model.dart';
import '../../specialoffers/model/expert_category_subcat_model.dart';
import '../../specialoffers/model/expert_subcat_cat_subcat_model.dart';
import '../../specialoffers/model/expert_subcategory_model.dart';

class PriceListController extends GetxController {
  final hideSubtopic = false.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final addButton = false.obs;
  String token = "";
  ///Category data
  final selectedCategoryIndex = (-1).obs;
  final categoryList = [].obs;
  final categoryString = "".obs;
  final sendDataList = [].obs;
  var categoryModel = ExpertCategorySubCatModel().obs;
  var subCatModel = ExpertSubCatCatSubCatModel().obs;
  final selectedCategoryId = ''.obs;
  final selectedCategory = ''.obs;


  //New Data Add
  final addTopicList = [].obs;

  Map jsonObject = {};

  updateItems() {

    var model = AddPriceModel();
    addTopicList.add(model);
  }

  removeItems(index) {
    addTopicList.removeAt(index);
  }

  @override
  void onInit() async {
    getUserSelectedSubCategory();
    // getCategoryApiFunction();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token").toString();
    update();
    super.onInit();
  }

  getUserSelectedSubCategory(){
    for(int i=0;i<Get.find<ExpertProfileController>().model.value.data!.expertSubcats!.length;i++){
      ExpertCategoryModel model =ExpertCategoryModel(id: Get.find<ExpertProfileController>().model.value.data!.expertSubcats![i].subCatId.toString(),
          name: Get.find<ExpertProfileController>().model.value.data!.expertSubcats![i].name
      );
      categoryList.add(model);
    }
  }

  getCategoryApiFunction() async {
    var body = {
      'category':'1'
    };
    final response = await ApiConstants.post(url: ApiUrls.expertSubCategoriesApiUrl,body: body);
    if (response != null && response['success'] == true) {
      if (response!=null&& response['success']!=false&& response['data'] != null) {
        categoryModel.value = ExpertCategorySubCatModel.fromJson(response);
      }
    }

  }


  getSubCategoryApiFunction(String id) async {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var body = {
      'sub_category_id':id
    };
    final response = await ApiConstants.post(url: ApiUrls.getSubCategoryListUrl,body: body);
    Get.back();
    if (response != null && response['success'] == true) {
      if (response!=null&& response['success']!=false&& response['data'] != null) {
          subCatModel.value = ExpertSubCatCatSubCatModel.fromJson(response);
      }
    }
    else{
    }
  }


  submitMultipleItems(BuildContext context, List dataList) async {
    showCircleProgressDialog(context);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer' + token
    };
    var request = http.Request('POST', Uri.parse(ApiUrls.expertAddMultipleItemApiUrl));
    request.body = json.encode({
      "sub_category_id": selectedCategoryId.value.toString(),
      "items": dataList,
    });
    print(request.body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    Get.back();
    if (response.statusCode == 200) {
      Get.back();
      //showToast(request[''])
    }
    else {
      print(response.reasonPhrase);
    }
  }


}

class AddPriceModel {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final title = ''.obs;
  final subCatId = ''.obs;
  final status = false.obs;
}

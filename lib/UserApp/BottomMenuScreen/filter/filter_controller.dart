import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senorita/UserApp/BottomMenuScreen/filter/filter_cat_model.dart';
import 'package:senorita/model/merge_category_model.dart';
import 'package:senorita/utils/showcircledialogbox.dart';
import 'package:senorita/utils/utils.dart';

import '../../../ExpertApp/BottomMenuScreen/specialoffers/model/expert_category_subcat_model.dart';
import '../../../ExpertApp/BottomMenuScreen/specialoffers/model/expert_subcat_cat_subcat_model.dart';
import '../../../api_config/ApiConstant.dart';
import '../../../api_config/Api_Url.dart';

class FilterController extends GetxController {
  final selectedFilterIndex = 0.obs;
  final selectedRating = 0.0.obs;
  final currentRangeValues = 0.0.obs;

  final isChangeDistanceValue = false.obs;
  List<FilterCatSubCatModel> categoryList = [];
  var subCatModel = ExpertSubCatCatSubCatModel().obs;
  var categoryModel = ExpertCategorySubCatModel().obs;
  final priceList = ["Low to High", "High to Low"].obs;
  final discountList = [
    '0-10',
    "10-30",
    "30-50",
    "50-70",
    "70-90",
    "Buy 1 Get 1"
  ];
  final ratingList = [
    '1 * & above',
    '2 * & above',
    '3 * & above',
    '4 * & above',
    '5 * & above',
  ];
  final selectedPriceValue = ''.obs;
  final selectedDiscountValue = ''.obs;
  var mergeCategoryModel = MergeCategoryModel().obs;

  /// if user comes from single screen
  final selectedCategoryNameBySingleScreen = ''.obs;
  final isShowSubCat = false.obs;
  final selectedCategoryIdBySingleScreen = ''.obs;

  final sortByList = ['Offers', 'Expert top rated', 'New Arrivals'].obs;
  final offerSortByList = ['Top Rated (5 Star)', 'New Arrivals'].obs;
  final selectedSort = 10.obs;

  final route = ''.obs;
  @override
  void onInit() async {
    isChangeDistanceValue.value = false;
    route.value = Get.arguments[0]!;
    selectedCategoryNameBySingleScreen.value = Get.arguments[2]! ?? "";
    selectedCategoryIdBySingleScreen.value = Get.arguments[1]! ?? "";

    Future.delayed(Duration.zero, () {
      if (route.value == 'offer' || selectedCategoryIdBySingleScreen.isEmpty) {
        print('sdgdfg');
        getCategoryApiFunction(Get.arguments[3]);
      } else {
        print('sdgsdfefsadvdfg');
        getSubCategoryApiFunction(Get.arguments[1], Get.arguments[3]);
      }
    });
    super.onInit();
  }

  setValues(body) {
    List catList = [];
    List subCatList = [];
    if (body != null) {
      if (route.value == 'offer' || selectedCategoryIdBySingleScreen.isEmpty) {
        selectedPriceValue.value = body['price'] == 'desc'
            ? priceList[0]
            : body['price'] == 'asc'
                ? priceList[1]
                : '';
        selectedDiscountValue.value = body['discount'];
        selectedSort.value = body['arrivals'].isNotEmpty
            ? 1
            : body['topRated'].isNotEmpty
                ? 0
                : 10;
        selectedRating.value =
            body['rating'].isNotEmpty ? double.parse(body['rating']) : 0.0;
        currentRangeValues.value =
            body['distance'].isNotEmpty ? double.parse(body['distance']) : 0.0;
        if (body['category'].isNotEmpty) {
          catList = body['category'].split(',').map(int.parse).toList();
        }
        if (body['subcat'].isNotEmpty) {
          subCatList = body['subcat'].split(',').map(int.parse).toList();
        }
        for (int i = 0; i < mergeCategoryModel.value.data!.length; i++) {
          for (int j = 0; j < catList.length; j++) {
            if (mergeCategoryModel.value.data![i].id.toString() ==
                catList[j].toString()) {
              mergeCategoryModel.value.data![i].isSelectedCat.value = true;
              mergeCategoryModel.value.selectedCategory.add({
                "name": mergeCategoryModel.value.data![i].name,
                "id": catList[j].toString()
              });
            }
          }
          for (int k = 0;
              k < mergeCategoryModel.value.data![i].subcategory!.length;
              k++) {
            for (int m = 0; m < subCatList.length; m++) {
              if (mergeCategoryModel.value.data![i].subcategory![k].id
                      .toString() ==
                  subCatList[m].toString()) {
                mergeCategoryModel.value.data![i].subcategory![k]
                    .isSelectedSubCat.value = true;
                mergeCategoryModel
                    .value.data![i].subcategory![k].selectedSubCategory
                    .add(subCatList[m].toString());
              }
            }
          }
        }
      } else {
        selectedPriceValue.value = body['price'] == 'desc'
            ? priceList[0]
            : body['price'] == 'asc'
                ? priceList[1]
                : '';
        selectedDiscountValue.value = body['discount'];
        selectedSort.value = body['arrivals'].isNotEmpty
            ? 2
            : body['topRated'].isNotEmpty
                ? 1
                : body['hasOffer'].isNotEmpty
                    ? 0
                    : 10;
        selectedRating.value =
            body['rating'].isNotEmpty ? double.parse(body['rating']) : 0.0;
        currentRangeValues.value =
            body['distance'].isNotEmpty ? double.parse(body['distance']) : 0.0;
        if (body['subcat'].isNotEmpty) {
          subCatList = body['subcat'].split(',').map(int.parse).toList();
        }
        for (int i = 0; i < subCatModel.value.data!.length; i++) {
          for (int j = 0; j < subCatList.length; j++) {
            if (subCatModel.value.data![i].id.toString() ==
                subCatList[j].toString()) {
              subCatModel.value.data![i].isSelected.value = true;
              subCatModel.value.selectedList.add(subCatList[j].toString());
            }
          }
        }
      }
    }
  }

  static String valueToString(double value) {
    return value.toStringAsFixed(0);
  }

  getCategoryApiFunction(values) async {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var body = {'category': '1'};
    print('sdfsdf');
    final response =
        await ApiConstants.post(url: ApiUrls.mergeCategoryListUrl, body: body);
    Get.back();
    if (response != null && response['success'] == true) {
      if (response != null &&
          response['success'] != false &&
          response['data'] != null) {
        mergeCategoryModel.value = MergeCategoryModel.fromJson(response);
        setValues(values);
      }
    }
  }

  getSubCategoryApiFunction(String id, values) async {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var body = {
      'category': id
      // 'sub_category_id':id
    };
    print({'sub_category_id': id});
    final response = await ApiConstants.post(
        url: ApiUrls.expertSubCategoriesApiUrl, body: body);
    Get.back();
    if (response != null && response['success'] == true) {
      if (response != null &&
          response['success'] != false &&
          response['data'] != null) {
        subCatModel.value = ExpertSubCatCatSubCatModel.fromJson(response);
        setValues(values);
      }
    } else {}
  }
}

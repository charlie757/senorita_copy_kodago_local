import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_profile_screen/controller/expert_profile_controller.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/specialoffers/model/expert_category_model.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/specialoffers/model/expert_category_subcat_model.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/specialoffers/model/expert_subcategory_model.dart';
import 'package:senorita/utils/showcircledialogbox.dart';
import 'package:senorita/utils/utils.dart';
import 'package:senorita/utils/validation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../helper/getText.dart';
import '../../../../utils/color_constant.dart';
import '../../../../utils/stringConstants.dart';
import '../model/expert_subcat_cat_subcat_model.dart';

class AddOfferController extends GetxController{
final selectedOfferType =0.obs;
final discountCategoryController = TextEditingController();
final discountSubCategoryController = TextEditingController();
final discountController = TextEditingController();
final discountDescriptionController = TextEditingController();
final discountStartDateController =TextEditingController();
final discountStartTimeController =TextEditingController();
final discountEndDateController =TextEditingController();
final discountEndTimeController =TextEditingController();


final buyCategoryController = TextEditingController();
final buySubCategoryController = TextEditingController();
final getSubCategoryController = TextEditingController();
final buyDescriptionController = TextEditingController();
final buyStartDateController =TextEditingController();
final buyStartTimeController =TextEditingController();
final buyEndDateController =TextEditingController();
final buyEndTimeController =TextEditingController();

final selectedDiscountCategoryIndex = (-1).obs;
final selectedBuyCategoryIndex = (-1).obs;
final selectedDiscountCategoryId = ''.obs;
final selectedDiscountCategory = ''.obs;
final selectedBuyCategory = ''.obs;
final selectedBuyCategoryId = ''.obs;
final selectedDiscountSubCat = [].obs;
final selectedBuySubCat = [].obs;
final selectedGetSubCat =[].obs;
final token = ''.obs;


final discountImgFile = Rx<File?>(null);
final buyImgFile = Rx<File?>(null);

DateTime selectedDiscountStartDate = DateTime.now();
DateTime selectedDiscountEndDate = DateTime.now();
DateTime selectedBuyStartDate = DateTime.now();
DateTime selectedBuyEndDate = DateTime.now();

TimeOfDay initialTime = const TimeOfDay(hour: 12, minute: 00);
TimeOfDay discountStartTime = const TimeOfDay(hour: 12, minute: 00);
TimeOfDay discountEndTime = const TimeOfDay(hour: 12, minute: 00);
TimeOfDay buyStartTime= const TimeOfDay(hour: 12, minute: 00);
TimeOfDay buyEndTime =const TimeOfDay(hour: 12, minute: 00);


final discountCategoryList = [].obs;
final buyCategoryList = [].obs;
var discountCategoryModel = ExpertCategorySubCatModel().obs;
var buyCategoryModel = ExpertCategorySubCatModel().obs;
var discountSubCatModel = ExpertSubCatCatSubCatModel().obs;
var buySubCatModel =  ExpertSubCatCatSubCatModel().obs;
var getSubCatModel =  ExpertSubCatCatSubCatModel().obs;


@override
void onInit() async {
  // getCategoryApiFunction();
  getUserSelectedSubCategory();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token.value = prefs.getString("token").toString();
  update();
  super.onInit();
}

getUserSelectedSubCategory(){
  for(int i=0;i<Get.find<ExpertProfileController>().model.value.data!.expertSubcats!.length;i++){
    ExpertCategoryModel model =ExpertCategoryModel(id: Get.find<ExpertProfileController>().model.value.data!.expertSubcats![i].subCatId.toString(),
    name: Get.find<ExpertProfileController>().model.value.data!.expertSubcats![i].name
    );
    buyCategoryList.add(model);
    discountCategoryList.add(model);
  }
}


getCategoryApiFunction() async {
  var body = {
    'category':'1'
  };
  final response = await ApiConstants.post(url: ApiUrls.expertSubCategoriesApiUrl,body: body);
  if (response != null && response['success'] == true) {
    if (response!=null&& response['success']!=false&& response['data'] != null) {
      discountCategoryModel.value = ExpertCategorySubCatModel.fromJson(response);
      buyCategoryModel.value = ExpertCategorySubCatModel.fromJson(response);
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
      if (selectedOfferType.value == 0) {
        discountSubCatModel.value = ExpertSubCatCatSubCatModel.fromJson(response);
      }
      else {
        buySubCatModel.value = ExpertSubCatCatSubCatModel.fromJson(response);
        getSubCatModel.value = ExpertSubCatCatSubCatModel.fromJson(response);
      }
    }
  }
  else{
    if (selectedOfferType.value == 0) {
      discountSubCatModel.value = ExpertSubCatCatSubCatModel.fromJson(response);
    }
    else {
      buySubCatModel.value = ExpertSubCatCatSubCatModel.fromJson(response);
      getSubCatModel.value = ExpertSubCatCatSubCatModel.fromJson(response);
    }
  }
}

checkValidation(){
 if(selectedOfferType.value==0){
   if(discountImgFile.value==null){
     errorSnackBar('Please upload photo', navigatorKey.currentContext);
   }
   else if(discountCategoryController.text.isEmpty){
     errorSnackBar('Please select Category', navigatorKey.currentContext);
   }
   else if(selectedDiscountSubCat.isEmpty){
     errorSnackBar('Please select sub category', navigatorKey.currentContext);
   }
   else if(discountController.text.isEmpty){
     errorSnackBar('Please enter the discount', navigatorKey.currentContext);
   }
   else if(discountDescriptionController.text.isEmpty){
     errorSnackBar('Please enter the description', navigatorKey.currentContext);
   }
   else if(discountStartDateController.text.isEmpty){
     errorSnackBar('Please select the start date', navigatorKey.currentContext);
   }
   else if(discountStartTimeController.text.isEmpty){
     errorSnackBar('Please select the start time', navigatorKey.currentContext);
   }
   else if(discountEndDateController.text.isEmpty){
     errorSnackBar('Please select the end date', navigatorKey.currentContext);
   }
   else if(discountEndTimeController.text.isEmpty){
     errorSnackBar('Please select the end time', navigatorKey.currentContext);
   }
   else{
     callSubmitApiFunction(navigatorKey.currentContext!);
   }
 }
 else{
   if(buyImgFile.value==null){
     errorSnackBar('Please upload photo', navigatorKey.currentContext);
   }
   else if(buyCategoryController.text.isEmpty){
     errorSnackBar('Please select Category', navigatorKey.currentContext);
   }
   else if(selectedBuySubCat.isEmpty){
     errorSnackBar('Please select buy sub category', navigatorKey.currentContext);
   }
   else if(selectedGetSubCat.isEmpty){
     errorSnackBar('Please select get sub category', navigatorKey.currentContext);
   }
   else if(buyDescriptionController.text.isEmpty){
     errorSnackBar('Please enter the description', navigatorKey.currentContext);
   }
   else if(buyStartDateController.text.isEmpty){
     errorSnackBar('Please select the start date', navigatorKey.currentContext);
   }
   else if(buyStartTimeController.text.isEmpty){
     errorSnackBar('Please select the start time', navigatorKey.currentContext);
   }
   else if(buyEndDateController.text.isEmpty){
     errorSnackBar('Please select the end date', navigatorKey.currentContext);
   }
   else if(buyEndTimeController.text.isEmpty){
     errorSnackBar('Please select the end time', navigatorKey.currentContext);
   }
   else{

     callSubmitApiFunction(navigatorKey.currentContext!);
   }
 }
}


callSubmitApiFunction(BuildContext context) async {
  showCircleProgressDialog(context);
  SharedPreferences prefs =await SharedPreferences.getInstance();
  var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.addOffer));
  request.headers.addAll({
    "Authorization": "Bearer ${prefs.getString(authToken)}",
  });
  if(selectedOfferType.value==0){
    var subCatId = selectedDiscountSubCat.map((element) => element['id']).join(',');
    request.fields.addAll({
      "type":'discount',
      "start_date": discountStartDateController.text,
      "start_time":discountStartTimeController.text,
      "end_date":discountEndDateController.text,
      "end_time":discountEndTimeController.text,
      "description":discountDescriptionController.text,
      "category_id":selectedDiscountCategoryId.value,
      "sub_category_id":discountSubCatModel.value.isAllSelected?'all': subCatId,
      "discount_pecent":discountController.text
    });
    print({
      "type":'discount',
      "start_date": discountStartDateController.text,
      "start_time":discountStartTimeController.text,
      "end_date":discountEndDateController.text,
      "end_time":discountEndTimeController.text,
      "description":discountDescriptionController.text,
      "category_id":selectedDiscountCategoryId.value,
      "sub_category_id":discountSubCatModel.value.isAllSelected?'all': subCatId,
      "discount_pecent":discountController.text
    });
    if (discountImgFile.value != null) {
      final file = await http.MultipartFile.fromPath('image', discountImgFile.value!.path);
      request.files.add(file);
    } else {}
  }
  else{
    var buySubCatId = selectedBuySubCat.map((element) => element['id']).join(',');
    var getSubCatId = selectedGetSubCat.map((element) => element['id']).join(',');
    request.fields.addAll({
      "type":'buyget',
      "start_date": buyStartDateController.text,
      "start_time":buyStartTimeController.text,
      "end_date":buyEndDateController.text,
      "end_time":buyEndTimeController.text,
      "description":buyDescriptionController.text,
      "category_id":selectedBuyCategoryId.value,
      "buy_category_id":buySubCatId,
      "get_category_id":getSubCatId,
    });
    if (buyImgFile.value != null) {
      final file = await http.MultipartFile.fromPath('image', buyImgFile.value!.path);
      request.files.add(file);
    } else {}

  }
  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  Get.back();
  log(response.body);
  final result = json.decode(response.body);
  if (response.statusCode == 200) {
    if (result["success"] == true) {
      Get.back();
      successSnackBar(result['message'], context);
    }
    else
    {
      errorSnackBar(result['message'], context);
      // showErrorMessageDialog(context, result["message"].toString());
    }
  }
else{
    errorSnackBar(result['message'], context);

  }
}



DateTime selectedDate = DateTime.now();

Future datePicker() async {
  DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData(colorSchemeSeed: ColorConstant.onBoardingBack),
          child: child!,
        );
      },
      helpText: "Select Date",
      context: navigatorKey.currentContext!,
      initialDate: selectedDate,
      firstDate: DateTime(1935, 1),
      lastDate: DateTime(2050, 12, 31));

  if (picked != null && picked != DateTime.now()) {
      selectedDate = picked;
      return selectedDate;
  }
}

Future selectTime(BuildContext context) async {
  TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      );
    },
  );
  return picked;
}
showImagePicker(BuildContext context) {
  showModalBottomSheet(
      elevation: 0,
      context: context,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      builder: (builder) {
        return SizedBox(
          height: 150,
          child: Center(
            child: Card(
              color: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))
                //set border radius more than 50% of height and width to make circle
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              pickImage(ImageSource.camera, context).then((value) {
                                if(selectedOfferType.value==0){
                                  discountImgFile.value = value;
                                }
                                else{
                                  buyImgFile.value =value;
                                }
                              });
                              Navigator.pop(context);
                            },
                            child: iconCreation(
                                Icons.camera_alt, Colors.pink, "Camera")),
                        GestureDetector(
                            onTap: () {
                              pickImage(ImageSource.gallery, context).then((value) {
                                if(selectedOfferType.value==0){
                                  discountImgFile.value = value;
                                }
                                else{
                                  buyImgFile.value =value;
                                }
                              });
                              Navigator.pop(context);
                            },
                            child: iconCreation(
                                Icons.insert_photo, Colors.purple, "Gallery"))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

Widget iconCreation(IconData icon, Color color, String text) {
  return Column(
    children: [
      CircleAvatar(
        backgroundColor: color,
        radius: 30,
        child: Icon(
          icon,
          size: 29,
          color: Colors.white,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      getText(
          title: text,
          size: 14,
          fontFamily: celiaRegular,
          color: ColorConstant.blackColor,
          fontWeight: FontWeight.w500),
    ],
  );
}

Future pickImage(ImageSource source, BuildContext context) async {
  final pickedFile = await ImagePicker().getImage(source: source);
  if (pickedFile != null) {
    return File(pickedFile.path);
  } else {
    //   showToast("Error" "No image selected");
  }
}
}

class ExpertCategoryModel{
  dynamic name = ''.obs;
  dynamic id = ''.obs;
  ExpertCategoryModel({
   required this.id,
    required this.name
});
}
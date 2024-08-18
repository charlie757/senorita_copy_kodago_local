import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senorita/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../ScreenRoutes/routes.dart';
import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../../../utils/size_config.dart';
import '../../../../widget/error_box.dart';
import '../../dashboard_screen/controller/dashboard_controller.dart';
import '../../profile_screen/controller/profile_controller.dart';

class EditProfileController extends GetxController {
  final fullNameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final profileFormKey = GlobalKey<FormState>();
  final isLoading = false.obs;
  String Id="";
  String token="";
  var profileController=Get.find<ProfileController>();


  @override
  Future<void> onInit() async {
    SizeConfig().init();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Id = prefs.getString("id").toString();
    token=prefs.getString("token").toString();
    setValues();
    super.onInit();
  }

  validation() async {
    if (profileFormKey.currentState!.validate()) {
      //loginApiFunction();
    }
  }

  void resetValues() {
    fullNameController.clear();
    fullNameController.text = "";

    numberController.clear();
    numberController.text = "";

    emailController.clear();
    emailController.text = "";
  }


  setValues(){
    if(profileController.model.value!=null&&profileController.model.value.data!=null){
      fullNameController.text=profileController.model.value.data!.name??"";
      numberController.text=profileController.model.value.data!.mobile??"";
      emailController.text=profileController.model.value.data!.email??'';
    }
  }
  uploadApiFunction(BuildContext context) async {
    showCircleProgressDialog(context);
    var headers = {
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiUrls.updateUserProfile + "/" + Id));
    request.fields.addAll({
      'name': fullNameController.text.toString(),
      'email': emailController.text.toString(),
      'mobile': numberController.text.toString(),
    });

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    Get.back();
    log(response.body);
    if (response.statusCode == 200) {
      final result = json.decode(response.body) ;
      if (result['success'] == true) {
        // profileController.profileApiFunction();
        Get.back();
        // Get.back();

      } else {
        showErrorMessageDialog(context, result["message"].toString());
      }
    }
  }





}

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:senorita/ScreenRoutes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../api_config/Api_Url.dart';
import '../../../api_config/preferencestorage.dart';
import '../../../utils/showcircledialogbox.dart';
import 'package:http/http.dart' as http;
import '../../../utils/toast.dart';
import '../../../widget/error_box.dart';

class OtpController extends GetxController {
  final isLoading = false.obs;
  final otpController = TextEditingController();
  final otpFormKey = GlobalKey<FormState>();
  final updateOtpFormKey = GlobalKey<FormState>();
  final counter = 0.obs;
  final isError = false.obs;
  Timer? timer;
  String refType = "";
  String mobileNumber = "";
  var messageOtpCode = ''.obs;
  @override
  void onInit() async {
    resetValues();
    startTimer();
    mobileNumber = Get.arguments[1];
    if (Get.arguments[0] == "login") {
      refType = "login";
    } else if (Get.arguments[0] == "update") {
      refType = "change_mobile";
    } else {
      refType = "register";
    }
    super.onInit();
  }

  startTimer() {
    //shows timer
    counter.value = 30; //time counter
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      counter.value > 0 ? counter.value-- : timer.cancel();
    });
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    timer?.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void resetValues() {
    otpController.clear();
  }

  verifyOtpApiFunction(BuildContext context) async {
    final userId =
        refType == 'change_mobile' ? Get.arguments[2].toString() ?? '' : "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showCircleProgressDialog(context);
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.submitOtp));
    request.fields.addAll({
      "mobile": mobileNumber,
      "device_token": prefs.getString('fcmToken').toString(),
      'otp': otpController.text,
      'ref_type': refType,
      'user_id': userId
    });
    print({
      "mobile": mobileNumber,
      "device_token": prefs.getString('fcmToken').toString(),
      'otp': otpController.text,
      'ref_type': refType,
      'user_id': userId
    });
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    log(response.body);
    Navigator.pop(context);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (refType == 'change_mobile') {
        if (result['success'] == true) {
          Navigator.pop(context);
        } else {
          resetValues();
          showErrorMessageDialog(context, result["message"].toString());
        }
      } else {
        if (result["success"] == true) {
          setAuthToken(result['token']);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', result['token'].toString());
          prefs.setBool('isLogin', true);
          if (result["data"]["user_type"].toString() == "2") {
            prefs.setBool('expertIsLogin', true);
            prefs.setString('id', result["data"]["id"].toString());
            prefs.setString(
                'expert_id', result['data']["expert_details"]["id"].toString());
            prefs.setString('expert_name', result['data']["name"].toString());
            prefs.setString(
                'expert_profile', result['data']["profile_picture"].toString());
            prefs.setString('status',
                result['data']["expert_details"]["status"].toString());
            prefs.setString('expert_qr_code', result['data']['expert_qr_code']);
            if (refType == 'change_mobile') {
              Navigator.pop(context);
              Navigator.pop(context);
            } else {
              Get.toNamed(AppRoutes.expertDashboardScreen);
            }
          } else {
            prefs.setString('id', result["data"]["id"].toString());
            prefs.setBool('userIsLogin', true);
            Get.toNamed(AppRoutes.dashboardScreen);
          }
        } else {
          resetValues();
          showErrorMessageDialog(context, result["message"].toString());
        }
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  resendOtpApiFunction(BuildContext context) async {
    showCircleProgressDialog(context);
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.resendOtp));
    request.fields.addAll({
      'mobile': mobileNumber,
      'ref_type': refType,
    });
    print({
      'mobile': mobileNumber,
      'ref_type': refType,
    });
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      // otpFormKey.currentState!.reset();
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result["success"] == true) {
        startTimer();
        Navigator.of(context).pop();
        showToast(result["message"].toString());
        // otpFormKey.currentState!.reset();
      } else {
        Navigator.of(context).pop();
        showErrorMessageDialog(context, result["message"].toString());
      }
    } else {
      Navigator.of(context).pop();
      print(response.reasonPhrase);
    }
  }
}

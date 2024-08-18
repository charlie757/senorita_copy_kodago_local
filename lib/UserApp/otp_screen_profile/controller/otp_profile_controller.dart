import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../api_config/Api_Url.dart';
import '../../../api_config/preferencestorage.dart';
import '../../../utils/showcircledialogbox.dart';
import 'package:http/http.dart' as http;
import '../../../utils/toast.dart';
import '../../../widget/error_box.dart';
import '../../../widget/success_box.dart';

class OtpProfileController extends GetxController {
  final isLoading = false.obs;
  final otpController = TextEditingController();
  final otpProfileFormKey = GlobalKey<FormState>();
  final counter = 0.obs;
  Timer? timer;
  String refType = "";
  String mobileNumber = "";
  var messageOtpCode = ''.obs;
  String id = "";

  @override
  void onInit() async {
    startTimer();

    if (Get.arguments[0] == "change_mobile") {
      refType = "change_mobile";
    }
    mobileNumber = Get.arguments[1];
    id = Get.arguments[2];
    super.onInit();
  }

  startTimer() {
    //shows timer
    counter.value = 120; //time counter
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
    otpController.text = "";
  }

  verifyOtpApiFunction(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showCircleProgressDialog(context);
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.submitOtp));
    request.fields.addAll({
      "mobile": mobileNumber,
      "device_token":prefs.getString('fcmToken').toString(),
      'otp': otpController.text,
      'ref_type': refType,
      'user_id': id,
    });
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result["success"] == true) {
        if (result["message"] == "OTP verified") {
          showToast(result["message"].toString());
          Get.offNamed(AppRoutes.dashboardScreen);
        }
      } else {
        Navigator.of(context).pop();
        showErrorMessageDialog(context, result["message"].toString());
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  resendOtpApiFunction(BuildContext context) async {
    showCircleProgressDialog(context);
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrls.resendOtp));
    request.fields.addAll({
      'mobile': mobileNumber,
      'ref_type': refType,
    });
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      otpProfileFormKey.currentState!.reset();
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result["success"] == true) {
        startTimer();

        Navigator.of(context).pop();
        showToast(result["message"].toString());
        otpProfileFormKey.currentState!.reset();
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

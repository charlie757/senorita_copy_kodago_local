import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:senorita/utils/utils.dart';
import 'package:senorita/utils/validation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../ScreenRoutes/routes.dart';
import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../helper/appimage.dart';
import '../../../../helper/getText.dart';
import '../../../../utils/color_constant.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../../../utils/size_config.dart';
import '../../../../utils/stringConstants.dart';
import '../../../../widget/error_box.dart';

class PaymentController extends GetxController {
  String id="";// Initialize with your desired upper value
  final amountController = TextEditingController();
  final onChange = false.obs;
  final isVisible = false.obs;
  final addMoneyFormKey = GlobalKey<FormState>();
  final selectedAmount = 0.obs;
 final token = ''.obs;
 final scannerCode = ''.obs;
 final salonName = ''.obs;
  @override
  Future<void> onInit() async {
    SizeConfig().init();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id=prefs.getString("id").toString();
    token.value = prefs.getString("token").toString();
    scannerCode.value = Get.arguments['scannerCode'];
    salonName.value = Get.arguments['name'];
    print("test..${scannerCode.value}");
    super.onInit();
  }

 callPaymentApiFunction()async {
   showCircleProgressDialog(Get.context!);
   var headers = {
     'Authorization': 'Bearer $token'
   };
   var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.scanCodePaymentUrl));
   request.fields.addAll({
     "scaner_code": scannerCode.value,
     "amount": amountController.text.toString(),
     "user_id": id.toString()
   });
   request.headers.addAll(headers);
   var streamedResponse = await request.send();
   var response = await http.Response.fromStream(streamedResponse)
       .timeout(const Duration(seconds: 60));
   log(response.body);
   print(response.statusCode);
   Get.back();
   final result = json.decode(response.body);
   if (response.statusCode == 200) {
     if (result['success'] == true && result['success'] != null) {
       showSuccessDialogBox();
     }else{
       errorSnackBar(result['message'], navigatorKey.currentContext!);
     }
   }else{
     errorSnackBar(result['message'], navigatorKey.currentContext!);

   }
  }

  void resetValues() {
    selectedAmount.value = 0;
    amountController.text = "";
  }

  showSuccessDialogBox(){
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: 1.2,
            child: Opacity(
              opacity: a1.value,
              child: PopScope(
                canPop: false,
                child: AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  shape: OutlineInputBorder(
                      borderSide:const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(16.0)

                  ),
                  content: SizedBox(
                    height: 250,
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50,),
                          Align(
                            alignment: Alignment.center,
                            child:  Image.asset(
                              height: 110,
                              width: 110,
                              AppImages.successPayment,
                              fit: BoxFit.contain,
                            ),
                          ),
                         const Spacer(),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: ()
                            {
                              Get.back();
                              Get.back();
                              Get.back();
                            },
                            child: Container(
                              decoration:const BoxDecoration(
                                  color:  ColorConstant.successful,
                                  borderRadius: BorderRadius.only(

                                    bottomRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),)
                              ),
                              alignment: Alignment.center,
                              height: 55,
                              child:  getText(
                                  title:"Payment Successful",
                                  size: 15,
                                  letterSpacing: 0.9,
                                  fontFamily: interSemiBold,
                                  color: ColorConstant.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),

                        ]),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: navigatorKey.currentContext!,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });

  }

}
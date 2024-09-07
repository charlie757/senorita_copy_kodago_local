import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../helper/appimage.dart';
import '../../helper/custombtn.dart';
import '../../helper/custombtn_new.dart';
import '../../helper/getText.dart';
import '../../utils/color_constant.dart';
import '../../utils/stringConstants.dart';
import '../../utils/screensize.dart';
import 'controller/otp_controller.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async
      {
        //Get.toNamed(AppRoutes.selectCreateAccount);
        Get.back();
        return false;
      },
      child: Scaffold(
        appBar: appBar(context, "", () {
          Get.back();
         // Get.toNamed(AppRoutes.selectCreateAccount);
        }),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  getText(
                      title: otpTitle,
                      size: 20,
                      fontFamily: interBold,
                      color: ColorConstant.blackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(14),
                  getText(
                      title: otpSubTitle,
                      size: 13,
                      fontFamily: celiaRegular,
                      color: ColorConstant.hintColor,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(14),
                  getText(
                      title: controller.mobileNumber,
                      size: 20,
                      fontFamily: celiaRegular,
                      color: ColorConstant.onBoardingBack,
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(24),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Pinput(
                      length: 6,

                      controller: controller.otpController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter otp';
                        } else if (val.length < 6) {
                          return 'Incorrect otp';
                        }
                      },
                      // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onCompleted: (pin) => print(pin),
                    ),),
                  Obx(()=>controller.isError.value?
                  Padding(padding:const EdgeInsets.only(top: 5,left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: getText(title: 'Enter otp',
                        size: 13, fontFamily: interMedium, color: ColorConstant.redColor,
                        fontWeight: FontWeight.w500),
                  ),
                  ):Container()),
                  ScreenSize.height(14),
                  Obx(
                    () => controller.counter.value != 0
                        ? RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: otpResend,
                                  style: TextStyle(
                                    color: ColorConstant.hintColor,
                                    fontSize: 13,
                                    fontFamily: celiaRegular,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${controller.counter.value}',
                                  style: TextStyle(
                                    color: ColorConstant.onBoardingBack,
                                    fontSize: 16,
                                    fontFamily: celiaRegular,
                                  ),
                                ),
                                TextSpan(
                                  text: ' sec',
                                  style: TextStyle(
                                    color: ColorConstant.onBoardingBack,
                                    fontSize: 16,
                                    fontFamily: celiaRegular,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Obx(() => InkWell(
                            onTap: () {
                              controller.resendOtpApiFunction(context);
                              //controller.resendApiFunction();
                              // controller.resendOtpApiFunction(context);
                            },
                            child: Visibility(
                                visible: true,
                                child: controller.counter.value != 0
                                    ? Text(
                                        otpNotReceive,
                                        style: TextStyle(
                                          color: ColorConstant.hintColor,
                                          fontSize: 14,
                                          fontFamily: celiaRegular,
                                        ),
                                      )
                                    : RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: otpNotReceive,
                                              style: TextStyle(
                                                color: ColorConstant.hintColor,
                                                fontSize: 13,
                                                fontFamily: celiaRegular,
                                              ),
                                            ),
                                            TextSpan(
                                              text: otpResend2,
                                              style: TextStyle(
                                                color: ColorConstant.onBoardingBack,
                                                fontSize: 13,
                                                fontFamily: celiaRegular,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: CustomBtnNew(
                          title: verification,
                          height: 50,
                          width: double.infinity,
                          color: ColorConstant.onBoardingBack,
                          onTap: () {
                            if(controller.otpController.text.length<6){
                              controller.isError.value=true;
                            }
                            else{
                              controller.isError.value=false;
                              controller.verifyOtpApiFunction(context);
                            }

                          }, rectangleBorder: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.transparent,width: 1.3),
                      borderRadius: BorderRadius.circular(10),), textColor: ColorConstant.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  AppBar appBar(BuildContext context, String title, Function() onTap) {
    return AppBar(
      backgroundColor: ColorConstant.white,
      elevation: 0,
      leadingWidth: 30,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
            height: 28,
            width: 28,
            alignment: Alignment.centerRight,
            child: GestureDetector(
                onTap: onTap,
                child: Image.asset(
                  AppImages.backIcon,
                  height: 28,
                  width: 28,
                ))),
      ),
      title: getText(
          title: title,
          size: 17,
          fontFamily: celiaBold,
          color: ColorConstant.blackColor,
          fontWeight: FontWeight.w400),
      centerTitle: true,
    );
  }

}

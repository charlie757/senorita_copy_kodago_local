import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:sms_autofill/sms_autofill.dart';
import '../../helper/custombtn.dart';
import '../../helper/getText.dart';
import '../../utils/color_constant.dart';
import '../../utils/stringConstants.dart';
import '../../utils/screensize.dart';
import 'controller/otp_profile_controller.dart';

class OtpScreenProfile extends GetView<OtpProfileController> {
  const OtpScreenProfile({key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async
      {
        Get.back();
        return false;
      },
      child: Scaffold(
        body: Form(
          key: controller.otpProfileFormKey,
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
                      fontFamily: celiaRegular,
                      color: ColorConstant.blackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(18),
                  getText(
                      title: otpSubTitle,
                      size: 15,
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
                    ),
                   /* Obx(
                          () => PinFieldAutoFill(
                        textInputAction: TextInputAction.done,
                        controller: controller.otpController,
                        decoration: UnderlineDecoration(
                          textStyle: const TextStyle(fontSize: 16, color: Colors.blue),
                          colorBuilder: const FixedColorBuilder(
                            Colors.transparent,
                          ),
                          bgColorBuilder: FixedColorBuilder(
                            Colors.grey.withOpacity(0.2),
                          ),
                        ),
                        currentCode: controller.messageOtpCode.value,
                        onCodeSubmitted: (code) {},
                        onCodeChanged: (code) {
                          controller.messageOtpCode.value = code!;
                          if (code.length == 6) {
                            // To perform some operation
                          }
                        },
                      ),
                    ),*/

                  ),
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
                                    fontSize: 15,
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
                                                fontSize: 14,
                                                fontFamily: celiaRegular,
                                              ),
                                            ),
                                            TextSpan(
                                              text: otpResend2,
                                              style: TextStyle(
                                                color: ColorConstant.onBoardingBack,
                                                fontSize: 14,
                                                fontFamily: celiaRegular,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
                    child: CustomBtn(
                          title: verification,
                          height: 50,
                          width: double.infinity,
                          color: ColorConstant.onBoardingBack,
                          onTap: () {
                            if (controller.otpProfileFormKey.currentState!.validate()) {
                              controller.verifyOtpApiFunction(context);

                            } else {
                              print(" not validate");
                            }

                          },
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
}

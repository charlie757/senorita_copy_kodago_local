import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../ScreenRoutes/routes.dart';
import '../../helper/appbar.dart';
import '../../helper/appimage.dart';
import '../../helper/custombtn_new.dart';
import '../../helper/getText.dart';
import '../../utils/color_constant.dart';
import '../../utils/stringConstants.dart';
import '../../utils/screensize.dart';
import '../../utils/toast.dart';
import '../../utils/validation.dart';
import '../../widget/customTextField.dart';
import 'controller/user_registration_controller.dart';

class UserRegistrationScreen extends GetWidget<UserRegistrationController> {
  const UserRegistrationScreen({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Create Account to User", () {
        Get.back();
      }),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: controller.formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenSize.height(50),
                    getText(
                        title: registerAccountSubTitle,
                        textAlign: TextAlign.center,
                        size: 14,
                        fontFamily: celiaRegular,
                        color: ColorConstant.blackColor,
                        fontWeight: FontWeight.w500),
                    ScreenSize.height(20),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CustomTextField(
                              hintText: "",
                              labelText: registerFullName,
                              textInputType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              auto: AutovalidateMode.onUserInteraction,
                              controller: controller.fullNameController,
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Please enter Full Name";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CustomTextField(
                              hintText: "",
                              labelText: registerMobileNumber,
                              auto: AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              textInputType: TextInputType.number,
                              controller: controller.numberController,
                              validator: (value) {
                                if (value == null ||
                                    value.length != 10 ||
                                    (!isValidPhone(value, isRequired: true))) {
                                  return "Mobile Number must be of 10 digit";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CustomTextField(
                              hintText: "",
                              labelText: registerEmailAddress,
                              auto: AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.done,
                              controller: controller.emailController,
                              // validator: (value) {
                              //   if (value == null ||
                              //       (!isValidEmail(value, isRequired: true))) {
                              //     return "Please enter valid email";
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CustomTextField(
                              hintText: "",
                              labelText: referralText,
                              textInputType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              // auto: AutovalidateMode.onUserInteraction,
                              controller: controller.referralController,
                              // validator: (value) {
                              //   if (value == null || value == "") {
                              //     return "Please enter Full Name";
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Obx(
                          () => Transform.translate(
                            offset: const Offset(-8, 0),
                            child: Transform.scale(
                              scale: 1.1,
                              child: Checkbox(
                                value: controller.checkBoxValue.value,
                                checkColor: ColorConstant.whiteColor,
                                activeColor: ColorConstant.onBoardingBack,
                                side: const BorderSide(
                                  color: ColorConstant
                                      .checkBox, //your desire colour here
                                  width: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      2,
                                    ),
                                    side: const BorderSide(
                                        color: Colors.deepPurple)),
                                onChanged: (bool? value) {
                                  controller.checkBoxValue.value = value!;
                                  if (value == true) {
                                    controller.termsConditionValue.value = 1;
                                  } else if (value == true) {
                                    controller.termsConditionValue.value = 0;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(-13, 0),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: loginAgree,
                                style: TextStyle(
                                  color: ColorConstant.grayColor,
                                  fontSize: 12,
                                  fontFamily: interRegular,
                                ),
                                children: [
                                  TextSpan(
                                    text: loginTerms,
                                    style: const TextStyle(
                                      color: ColorConstant.onBoardingBack,
                                      fontSize: 12,
                                      fontFamily: interRegular,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(AppRoutes.helpSupportScreen,
                                            arguments: ['termsCondition', ""]);
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ScreenSize.height(15),
                    Obx(
                      () => CustomBtnNew(
                        title: createBtn,
                        height: 50,
                        width: double.infinity,
                        color: ColorConstant.onBoardingBack,
                        isLoading: controller.isLoading.value,
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            if (controller.checkBoxValue.value) {
                              controller.signUpApiFunction(context);
                            } else {
                              showToast(signUpCheckBoxValidation);
                            }
                          } else {}
                        },
                        textColor: ColorConstant.whiteColor,
                        rectangleBorder: RoundedRectangleBorder(
                          side:
                              BorderSide(color: Colors.transparent, width: 1.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    ScreenSize.height(15),
                    /* Center(
                      child: Padding(
                        padding:  const EdgeInsets.only(top: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const getText(
                                title: registerAlreadyAccount,
                                size: 14,
                                fontFamily: interRegular,
                                color: ColorConstant.lightGray,
                                fontWeight: FontWeight.w800),
                            const SizedBox(width: 5,),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: ()
                              {
                                Get.offNamed(AppRoutes.loginScreen);
                                controller.resetValues();
                                controller.checkBoxValue.value=false;
                              },
                              child: getText(
                                  title: registerLogin,
                                  size: 14,
                                  fontFamily: interRegular,
                                  letterSpacing: 0.3,
                                  color: ColorConstant.onBoardingBack,
                                  fontWeight: FontWeight.w800),
                            ),

                          ],
                        ),
                      ),
                    ),*/
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const getText(
                                title: registerAlreadyAccount,
                                size: 12,
                                fontFamily: interRegular,
                                color: ColorConstant.lightGray,
                                fontWeight: FontWeight.w500),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Get.offNamed(AppRoutes.loginScreen);
                                controller.resetValues();
                                controller.checkBoxValue.value = false;
                              },
                              child: getText(
                                  title: registerLogin,
                                  size: 12,
                                  fontFamily: interRegular,
                                  color: ColorConstant.onBoardingBack,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ScreenSize.height(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          color: ColorConstant.dividerColor,
                          height: 1,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        getText(
                            title: or,
                            textAlign: TextAlign.start,
                            size: 13,
                            fontFamily: interMedium,
                            color: ColorConstant.lightGray,
                            fontWeight: FontWeight.w400),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 150,
                          color: ColorConstant.dividerColor,
                          height: 1,
                        ),
                      ],
                    ),
                    ScreenSize.height(6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // controller.signup(context);
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: ColorConstant.cardBack,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                AppImages.google,
                              ),
                            ),
                          ),
                        ),
                        ScreenSize.width(30),
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: ColorConstant.cardBack,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              AppImages.facebook,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../helper/appimage.dart';
import '../../helper/custombtn.dart';
import '../../helper/getText.dart';
import '../../utils/color_constant.dart';
import '../../utils/stringConstants.dart';
import '../../utils/screensize.dart';
import '../../widget/customTextField.dart';
import 'controller/changePassword_controller.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarColor: Colors.black45,
    //     statusBarIconBrightness: Brightness.light
    //     //color set to transperent or set your own color
    //     ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.white,
        elevation: 0,
        leadingWidth: 30,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
              height: 28,
              width: 28,
              alignment: Alignment.center,
              child: GestureDetector(
                  onTap: ()
                  {
                    Get.back();
                  },
                  child: Image.asset(
                    AppImages.backIcon,
                    height: 28,
                    width: 28,
                  ))),
        ),
        title: getText(
            title: "Change Password",
            size: 17,
            fontFamily: celiaMedium,
            color: ColorConstant.blackColor,
            fontWeight: FontWeight.w400),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Form(
              key: controller.changePasswordFormKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 28, right: 28, top: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenSize.height(10),

                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CustomTextField(
                              hintText: "",
                              labelText: changePasswordOld,
                              auto: AutovalidateMode.onUserInteraction,
                              controller: controller.oldPasswordController,
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Please enter OldPassword";
                                }
                                return null;
                              },
                            ),
                          ),

                         SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CustomTextField(
                              hintText: "",
                              labelText: changePasswordNew,
                              auto: AutovalidateMode.onUserInteraction,
                              controller: controller.newPasswordController,
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Enter new Password";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CustomTextField(
                              hintText: "",
                              labelText: changePasswordConform,
                              auto: AutovalidateMode.onUserInteraction,
                              controller: controller.conformPasswordController,
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Please confirm Password";
                                }
                                return null;
                              },
                            ),
                          ),


                        ],
                      ),
                    ),
                    ScreenSize.height(50),
                    Obx(
                      () => CustomBtn(
                          title: profileUpdateBtn,
                          height: 50,
                          width: double.infinity,
                          color: ColorConstant.onBoardingBack,
                          isLoading: controller.isLoading.value,
                          onTap: () {
                            controller.isLoading.value
                                ? null
                                : controller.validation();
                          }),
                    ),
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

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../helper/appimage.dart';
import '../../../helper/custombtn.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/screensize.dart';
import '../../../utils/stringConstants.dart';
import '../../../utils/validation.dart';
import '../../../widget/customTextField.dart';
import 'controller/editProfile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, () {
        Get.back();
      }),
      body: Form(
        key: controller.profileFormKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10,bottom: 20),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CustomTextField(
                          hintText: "",
                          labelText:registerFullName,
                          auto: AutovalidateMode.onUserInteraction,
                          controller: controller.fullNameController,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Please enter FullName";
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
                          labelText:registerMobileNumber,
                          auto: AutovalidateMode.onUserInteraction,
                          controller: controller.numberController,
                          isReadOnly: true,
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(10),
                          ],
                          textInputType: TextInputType.phone,
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
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CustomTextField(
                          hintText: "",
                          labelText:registerEmailAddress,
                          auto: AutovalidateMode.onUserInteraction,
                          controller: controller.emailController,
                          validator: (value) {
                            if (value == null ||
                                (!isValidEmail(value, isRequired: true))) {
                              return "Please enter valid email";
                            }
                            return null;
                          },
                        ),
                      ),


                    ],
                  ),
                ),
                Obx(
                  () => CustomBtn(
                      title: "Save",
                      height: 50,
                      width: double.infinity,
                      color: ColorConstant.onBoardingBack,
                      isLoading: controller.isLoading.value,
                      onTap: () {
                        if (controller.profileFormKey.currentState!.validate()) {
                          controller.uploadApiFunction(context);
                        } else {}
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  AppBar appBar(BuildContext context, Function() onTap) {
    return AppBar(
      backgroundColor: ColorConstant.white,
      elevation: 0,
      leadingWidth: 30,
      automaticallyImplyLeading: false,
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 25,
                    width: 25,
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppImages.backIcon,
                      color: Colors.black87,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),

                Center(
                  child: getText(
                      title: "Personal Information",
                      size: 18,
                      fontFamily: interSemiBold,
                      color: ColorConstant.blackColor,
                      fontWeight: FontWeight.w500),
                ),
                Center(
                  child: getText(
                      title: "",
                      size: 16,
                      fontFamily: interSemiBold,
                      color: ColorConstant.blackColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        )
      ],
      centerTitle: true,
    );
  }

}

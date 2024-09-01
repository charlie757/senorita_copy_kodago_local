import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../ScreenRoutes/routes.dart';
import '../../helper/appimage.dart';
import '../../helper/custombtn.dart';
import '../../helper/custombtn_new.dart';
import '../../helper/getText.dart';
import '../../utils/color_constant.dart';
import '../../utils/stringConstants.dart';
import '../../utils/screensize.dart';
import 'controller/createAccount_type_controller.dart';

class SelectCreateAccountScreen extends GetView<CreateAccountTypeController> {
  const SelectCreateAccountScreen({key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
          appBar: appBar(context, "", () {
            Get.back();
          }),
          backgroundColor: Colors.white,
          // backgroundColor: ColorConstant.backgrounType,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  getText(
                      title: selectRole,
                      size: 25,
                      textAlign: TextAlign.center,
                      fontFamily: interBold,
                      letterSpacing: 0.6,
                      color: ColorConstant.blackColor,
                      fontWeight: FontWeight.w500),
                  // const SizedBox(
                  //    height: 10,
                  //  ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width / 1.3,
                  //   child: RichText(
                  //     textAlign: TextAlign.center,
                  //     text: const TextSpan(
                  //       text:
                  //           "If you're searching for nearby salons MUA's or beauty store select",
                  //       style:  TextStyle(
                  //         color: ColorConstant.darkGray,
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 12,
                  //         height: 1.5,
                  //         fontFamily: interRegular,
                  //       ),
                  //       children: <TextSpan>[
                  //          TextSpan(
                  //             text: ' "User"',
                  //             style:  TextStyle(
                  //               color: ColorConstant.darkGray,
                  //               fontSize: 13,
                  //               fontWeight: FontWeight.w600,
                  //               fontFamily: interRegular,
                  //             )),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        child: Card(
                          color: ColorConstant.selectUserRoleBack,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                  color: ColorConstant.onBoardingBack)
                              //set border radius more than 50% of height and width to make circle
                              ),
                          elevation: 0,
                          child: SizedBox(
                            width: 140,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppImages.userIcon,
                                    height: 85,
                                    width: 85,
                                  ),
                                  const SizedBox(height: 10),
                                  getText(
                                      title: "User",
                                      size: 14,
                                      textAlign: TextAlign.start,
                                      fontFamily: interRegular,
                                      color: ColorConstant.blackColor,
                                      fontWeight: FontWeight.w600),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: CustomBtnNew(
                        title: selectRoleButton,
                        height: 46,
                        width: double.infinity,
                        rectangleBorder: RoundedRectangleBorder(
                          side:
                              BorderSide(color: Colors.transparent, width: 1.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: ColorConstant.onBoardingBack,
                        onTap: () {
                          Get.toNamed(AppRoutes.userRegistrationScreen);
                        },
                        textColor: ColorConstant.whiteColor),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
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
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.expertRegistrationScreen);
                  //Get.toNamed(AppRoutes.userRegistrationScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Text(
                    "Click here if you want to list\nyour Brnad",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: interMedium,
                        height: 1.5,
                        color: ColorConstant.lightGray,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  AppBar appBar(BuildContext context, String title, Function() onTap) {
    return AppBar(
      backgroundColor: Colors.transparent,
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

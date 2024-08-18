import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:senorita/UserApp/BottomMenuScreen/dashboard_screen/controller/dashboard_controller.dart';
import 'package:senorita/utils/utils.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../helper/appimage.dart';
import '../../../helper/custombtn.dart';
import '../../../helper/custombtn_new.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/logoutdialogbox_user.dart';
import '../../../utils/screensize.dart';
import '../../../utils/stringConstants.dart';
import '../../../utils/toast.dart';
import '../../../utils/validation.dart';
import '../../../widget/customTextField.dart';
import 'controller/profile_controller.dart';

class Profile extends GetWidget<ProfileController> {
  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = DashboardController();

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorConstant.screenBack.withOpacity(0.4),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Column(
                children: [
                 const SizedBox(
                    height: 55,
                  ),
                  Center(
                    child: getText(
                        title: "Profile ",
                        size: 18,
                        fontFamily: interSemiBold,
                        color: ColorConstant.blackColor,
                        fontWeight: FontWeight.w600),
                  ),
                const  SizedBox(
                    height: 30,
                  ),
                  Obx(()=>controller.model!= null&&controller.model.value.data!=null&&
                      controller.model.value.data!.profilePicture!=null?
                    ClipOval(
                      child: CachedNetworkImage(
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                        imageUrl:controller.model.value.data!.profilePicture,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>const  Icon(Icons.person),
                      ),
                    ):Container(),
                  ),
                  ScreenSize.height(12),
                  Obx(
                    () => Center(
                      child: getText(
                          title:controller.model!= null&&controller.model.value.data!=null?
                          controller.model.value.data!.name??'':"",
                          size: 16,
                          fontFamily: interSemiBold,
                          color: ColorConstant.blackColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                const  SizedBox(
                    height: 5,
                  ),
                  Obx(
                    () => Center(
                      child: getText(
                          title: controller.model!= null&&controller.model.value.data!=null?
                          controller.model.value.data!.mobile??'':"",
                          size: 14,
                          fontFamily: interRegular,
                          color: ColorConstant.blackLight,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
             const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorConstant.white,
                      borderRadius:const BorderRadius.only(
                        topRight: Radius.circular(16),topLeft: Radius.circular(16)
                      ),
                      boxShadow: [
                        BoxShadow(
                            offset:const Offset(0, 3),
                            color: ColorConstant.black3333.withOpacity(.2),
                            blurRadius: 14
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      profileTypesWidget(title: 'Personal Information', img: AppImages.profileUsers, onTap: () {
                        Get.toNamed(AppRoutes.editProfile)?.then((value) {
                          controller.onInit();
                        });
                      },),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(navigatorKey.currentContext!).size.width - 30,
                        color: ColorConstant.dividerColor,
                        height: 1,
                      ),
                      profileTypesWidget(title: 'Wallet', img: AppImages.profileWallet, onTap: () {
                        Get.toNamed(AppRoutes.walletScreen);
                      },),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(navigatorKey.currentContext!).size.width - 30,
                        color: ColorConstant.dividerColor,
                        height: 1,
                      ),

                      profileTypesWidget(title: 'Terms & Condition', img: AppImages.profileTerms, onTap: () {
                        Get.toNamed(AppRoutes.helpSupportScreen,
                            arguments: ['termsCondition', ""]);
                      },),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(navigatorKey.currentContext!).size.width - 30,
                        color: ColorConstant.dividerColor,
                        height: 1,
                      ),

                      profileTypesWidget(title: 'Help & Support', img: AppImages.profileHelp, onTap: () {
                        Get.toNamed(AppRoutes.helpSupportScreen,
                            arguments: ['helpSupport', ""]);
                      },),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(navigatorKey.currentContext!).size.width - 30,
                        color: ColorConstant.dividerColor,
                        height: 1,
                      ),

                      profileTypesWidget(title: 'Refer & Earn', img: AppImages.profileUsers, onTap: () {
                        Get.toNamed(AppRoutes.referEarnScreen,);
                      },),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(navigatorKey.currentContext!).size.width - 30,
                        color: ColorConstant.dividerColor,
                        height: 1,
                      ),
                      profileTypesWidget(title: 'Logout', img: AppImages.profileLogout, onTap: () {
                        userLogoutDialogBox(context, dashboardController);
                      },)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  profileTypesWidget({required String title,required String img, required Function()onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:
        const EdgeInsets.only(left: 12, right: 12, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Center(
                    child: Image.asset(
                      height: 28,
                      width: 28,
                      img,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              const  SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Center(
                    child: getText(
                        title: title,
                        size: 14,
                        fontFamily: interMedium,
                        color: ColorConstant.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Center(
                child: Image.asset(
                  height: 20,
                  width: 20,
                  AppImages.arrow,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void userLogoutDialogBox(
    BuildContext context,
    DashboardController dashboardController,
  ) {
    showGeneralDialog(

        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                backgroundColor: ColorConstant.white,
                shape: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConstant.white),
                    borderRadius: BorderRadius.circular(16.0)),
                content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getText(
                          title: 'Logout',
                          size: 18,
                          fontFamily: celiaRegular,
                          color: ColorConstant.blackColor,
                          fontWeight: FontWeight.w600),
                      ScreenSize.height(15),
                     const getText(
                          title: 'Are you sure want to logout?',
                          size: 13,
                          fontFamily: celiaRegular,
                          color: ColorConstant.black3333,
                          fontWeight: FontWeight.w400),
                      ScreenSize.height(30),
                      Row(
                        children: [
                          Flexible(
                              child: CustomBtn(
                                  title: 'No',
                                  height: 44,
                                  width: 100,
                                  color: ColorConstant.c0Color,
                                  onTap: () {
                                    Get.back();
                                  })),
                          ScreenSize.width(15),
                          Flexible(
                              child: CustomBtn(
                                  title: 'Yes',
                                  height: 44,
                                  width: 100,
                                  color: ColorConstant.onBoardingBack,
                                  onTap: () {
                                    dashboardController.logout();
                                  })),
                        ],
                      )
                    ]),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }
}

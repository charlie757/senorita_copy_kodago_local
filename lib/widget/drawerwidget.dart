import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ScreenRoutes/routes.dart';
import '../UserApp/BottomMenuScreen/dashboard_screen/controller/dashboard_controller.dart';
import '../helper/appimage.dart';
import '../helper/getText.dart';
import '../utils/color_constant.dart';
import '../utils/logoutdialogbox_user.dart';
import '../utils/stringConstants.dart';
import '../utils/screensize.dart';

drawer(BuildContext context, DashboardController dashboardController,) {
  return Container(
    width: MediaQuery.of(context).size.width - 70,
    height: double.infinity,
    color: ColorConstant.onBoardingBack.withOpacity(0.99),
    child: Column(
      children: [
        ScreenSize.height(50),
        Padding(
          padding: const EdgeInsets.only(left: 21),
          child: Row(
            children: [
              Obx(()=>
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*Obx(
                          () => dashboardController.profile.value == 'null'
                          ? Container(
                        height: SizeConfig
                            .screenHeightConstant *
                            7,
                        width: SizeConfig
                            .screenHeightConstant *
                            7,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: Colors.white),
                            shape: BoxShape.circle,
                            image:
                            const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(

                                AppImages.detailImg,
                              ),
                            )),
                      )
                          : ClipOval(
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(
                              10),
                          child: Image.network(
                            dashboardController.profileUrl.value,
                            fit: BoxFit.fitWidth,
                            height: SizeConfig
                                .screenHeightConstant *
                                7,
                            width: SizeConfig
                                .screenHeightConstant *
                                7,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),*/
                    Container(
                      width: MediaQuery.of(context).size.width/1.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          getText(
                              title: dashboardController.name.value,
                              size: 20,
                              fontFamily: celiaMedium ,
                              color: ColorConstant.white,
                              fontWeight: FontWeight.w400),
                          SizedBox(height: 5,),
                          getText(
                              title: dashboardController.email.value,
                              size: 14,
                              fontFamily: celiaRegular ,
                              color: ColorConstant.white,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                    )

                  ],
                ),
              ),

            ],
          ),
        ),
        ScreenSize.height(20),
        Container(
          height: 1,
          color: ColorConstant.c0Color,
        ),
        Expanded(
            child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              ScreenSize.height(20),
              drawerItemWidget(drawerHome, AppImages.drawerHome, () {
                Get.back();
                dashboardController.selectIndex.value=0;
              }),
              ScreenSize.height(10),
              drawerItemWidget(drawerProfile, AppImages.drawerUsers, () {
                Get.back();
                Get.toNamed(AppRoutes.profile)?.then((value) {
                  dashboardController.profileApiFunction();
                  dashboardController.selectIndex.value=1;
                  //Get.back();

                });
                /*Get.back();
                Get.toNamed(AppRoutes.profileScreen);
                dashboardController.selectIndex.value=3;*/
              }),
              ScreenSize.height(10),
              drawerItemWidget(drawerSupport, AppImages.drawerSupport, () {
                Get.back();
                Get.toNamed(AppRoutes.helpSupportScreen,arguments: ['helpSupport']);
                dashboardController.selectIndex.value=4;
              }),
              ScreenSize.height(10),
              drawerItemWidget(drawerTerms, AppImages.drawerTerms, () {
                Get.back();
                Get.toNamed(AppRoutes.helpSupportScreen,arguments: ["termsCondition"]);
                dashboardController.selectIndex.value=5;
              }),
              ScreenSize.height(10),
              drawerItemWidget("Log Out", AppImages.logout, () {
                Get.back();
                userLogoutDialogBox(context, dashboardController);
              }),
            ],
          ),
        ))
      ],
    ),
  );
}

drawerItemWidget(String title, String img, Function() onTap) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 21),
      height: 50,
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            child: Image.asset(
              img,
              color: Colors.white,
              height: 25,
              width: 25,
            ),
          ),
          ScreenSize.width(25),
          getText(
              title: title,
              size: 14,
              fontFamily: celiaMedium,
              color: ColorConstant.white,
              fontWeight: FontWeight.w400)
        ],
      ),
    ),
  );
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senorita/utils/screensize.dart';
import '../ExpertApp/BottomMenuScreen/expert_dashboard_screen/controller/dashboard_controller.dart';
import '../helper/custombtn.dart';
import '../helper/getText.dart';
import 'color_constant.dart';
import 'stringConstants.dart';

void logoutDialogBox(BuildContext context, ExpertDashboardController expertDashboardController,) {
  showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getText(
                        title: 'Logout',
                        size: 18,
                        fontFamily: celiaRegular,
                        color: ColorConstant.blackColor,
                        fontWeight: FontWeight.w600),
                    ScreenSize.height(15),
                    getText(
                        title: 'Are you sure want to logout?',
                        size: 15,
                        fontFamily: celiaRegular,
                        color: ColorConstant.blackColor,
                        fontWeight: FontWeight.w400),
                    ScreenSize.height(30),
                    Row(
                      children: [
                        Flexible(
                            child: CustomBtn(
                                title: 'No',
                                height: 44,
                                width: 100,
                                color: ColorConstant.onBoardingBack,
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
                                  //expertDashboardController.logout();
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

import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../helper/appbar.dart';
import '../../../helper/appimage.dart';
import '../../../helper/custombtn_new.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/screensize.dart';
import '../../../utils/stringConstants.dart';
import '../../../utils/toast.dart';
import '../../../utils/validation.dart';
import '../../../widget/customTextField.dart';
import 'controller/report_controller.dart';

class ReportScreen extends GetWidget<ReportController> {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.back();
          return true;
        },
        child: Scaffold(
            appBar: appBar(context, "Report Review", () {
              Get.back();
            }),
            backgroundColor: ColorConstant.white.withOpacity(0.4),
            body: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 15,bottom: 55),
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {},
                      child: walletTransaction(context, index));
                }),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  height: 65,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 4, right: 4, top: 15, bottom: 0),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                              left: 0, right: 5, top: 13, bottom: 13),
                          decoration: BoxDecoration(
                              color: ColorConstant.onBoardingBack,
                              borderRadius: BorderRadius.all(Radius.circular(7))),
                          child: Center(
                            child: getText(
                                title: "Apply",
                                size: 17,
                                fontFamily: interRegular,
                                color: ColorConstant.white,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                      )),
                ))));
  }

  walletTransaction(BuildContext context, index) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 6),
      child: GestureDetector(
        onTap: () {
          controller.selectedReport.value = index;
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 15,
                color: ColorConstant.dividerColor,
                height: 1,
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Obx(
                      () => Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: controller.selectedReport.value == index
                              ? Icon(
                                  size: 20,
                                  color: ColorConstant.onBoardingBack,
                                  Icons.radio_button_on)
                              : Icon(
                                  size: 20,
                                  color: ColorConstant.onBoardingBack,
                                  Icons.radio_button_off)),
                    ),
                    /*controller.selectedReport.value ==
                        index
                        ? Icon(
                      size: 7,
                      Icons.radio_button_checked,
                      color: ColorConstant
                          .onBoardingBack,
                    )
                        : Icon(
                      Icons.radio_button_off_outlined,
                    ),*/
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getText(
                              title: "Irrelevant",
                              size: 15,
                              fontFamily: interMedium,
                              color: ColorConstant.blackColor,
                              fontWeight: FontWeight.w600),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 29),
                child: getText(
                    title:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been.",
                    size: 14,
                    fontFamily: interRegular,
                    textOverflow: TextOverflow.visible,
                    color: ColorConstant.qrViewText,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

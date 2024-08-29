import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:senorita/UserApp/BottomMenuScreen/profile_screen/controller/profile_controller.dart';
import 'package:senorita/UserApp/BottomMenuScreen/refer_earn/referearn_controller.dart';
import 'package:senorita/helper/appbar.dart';
import 'package:senorita/helper/appimage.dart';
import 'package:senorita/helper/getText.dart';
import 'package:senorita/utils/color_constant.dart';
import 'package:senorita/utils/screensize.dart';
import 'package:senorita/utils/stringConstants.dart';
import 'package:share_plus/share_plus.dart';

class ReferEarnScreen extends GetView<ReferEarnController> {
  const ReferEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Refer & Earn", () {
        Get.back();
      }),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80),
              child: Image.asset(AppImages.referEarnImage),
            ),
            ScreenSize.height(5),
            Align(
              alignment: Alignment.center,
              child: getText(
                  title: 'Invite your Friend and get\n200 in Wallet.',
                  textAlign: TextAlign.center,
                  size: 16,
                  fontFamily: poppinsMedium,
                  color: ColorConstant.blackColor,
                  fontWeight: FontWeight.w600),
            ),
            ScreenSize.height(26),
            referCodeAndShareWidget(),
            howItWorksWidget()
          ],
        ),
      ),
    );
  }

  referCodeAndShareWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22),
      child: Row(
        children: [
          Expanded(
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(6),
              color: const Color(0xff7DBAE2),
              padding: EdgeInsets.zero,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xff7DBAE2)),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                          Get.find<ProfileController>().model != null &&
                                  Get.find<ProfileController>()
                                          .model
                                          .value
                                          .data !=
                                      null &&
                                  Get.find<ProfileController>()
                                          .model
                                          .value
                                          .data!
                                          .referralCode !=
                                      null
                              ? Get.find<ProfileController>()
                                  .model
                                  .value
                                  .data!
                                  .referralCode
                              : "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: poppinsRegular,
                              color: const Color(0xff4F4F52),
                              fontWeight: FontWeight.w400)),
                    ),
                    ScreenSize.width(5),
                    GestureDetector(
                        onTap: () {
                          if (Get.find<ProfileController>().model != null &&
                              Get.find<ProfileController>().model.value.data !=
                                  null &&
                              Get.find<ProfileController>()
                                      .model
                                      .value
                                      .data!
                                      .referralCode !=
                                  null) {
                            Clipboard.setData(ClipboardData(
                                text: Get.find<ProfileController>()
                                    .model
                                    .value
                                    .data!
                                    .referralCode));
                            Fluttertoast.showToast(
                                msg: 'Copied', gravity: ToastGravity.CENTER);
                          }
                        },
                        child: Image.asset(
                          AppImages.copyIcon,
                          height: 24,
                          width: 24,
                        ))
                  ],
                ),
              ),
            ),
          ),
          ScreenSize.width(26),
          GestureDetector(
            onTap: () {
              Share.share(
                  'Download only using my referral link to get coins\n ${Get.find<ProfileController>().model.value.data!.referralCode}\n\n https://play.google.com/store/apps/details?id=com.app.kodagolocal',
                  subject: 'Kodago Local');
            },
            child: Container(
              height: 48,
              width: 87,
              decoration: BoxDecoration(
                  color: ColorConstant.appColor,
                  borderRadius: BorderRadius.circular(6)),
              alignment: Alignment.center,
              child: getText(
                  title: 'Share',
                  size: 16,
                  fontFamily: poppinsMedium,
                  color: ColorConstant.white,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  howItWorksWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22, top: 45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getText(
              title: 'How it work',
              size: 20,
              fontFamily: interBold,
              color: ColorConstant.blackColor,
              fontWeight: FontWeight.w600),
          ScreenSize.height(23),
          howWorksContent(
              "1", 'Share code', 'Friend uses your code to register'),
          ScreenSize.height(31),
          howWorksContent("2", 'You get rewards',
              'Your Friends get 200 point when they sign up with your invite code'),
        ],
      ),
    );
  }

  howWorksContent(String number, String title, String subTitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 23,
          width: 23,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorConstant.appColor),
          alignment: Alignment.center,
          child: getText(
              title: number,
              size: 14,
              fontFamily: poppinsMedium,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
        ScreenSize.width(19),
        Flexible(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getText(
                title: title,
                size: 16,
                fontFamily: poppinsMedium,
                color: ColorConstant.blackColor,
                fontWeight: FontWeight.w500),
            Text(
              subTitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 13,
                  fontFamily: poppinsRegular,
                  color: Color(0xff767676),
                  fontWeight: FontWeight.w400),
            )
          ],
        ))
      ],
    );
  }
}

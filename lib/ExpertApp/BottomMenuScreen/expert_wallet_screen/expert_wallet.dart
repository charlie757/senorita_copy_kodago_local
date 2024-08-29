import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_profile_screen/controller/expert_profile_controller.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_qr_screen/expertQrScreen.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../helper/appbar.dart';
import '../../../helper/appimage.dart';
import '../../../helper/custombtn_new.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/stringConstants.dart';
import '../../../utils/time_format.dart';

import '../../../widget/no_data_found.dart';
import 'controller/expert_wallet_controller.dart';

class ExpertWalletScreen extends GetWidget<ExpertWalletController> {
  const ExpertWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ExpertProfileController());
    return Scaffold(
      appBar: appBar(context, 'Wallet', isShowLeading: false, () => null),
      backgroundColor: ColorConstant.checkBox.withOpacity(0.1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: ColorConstant.walletCard,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 3),
                        color: ColorConstant.black3333.withOpacity(.2),
                        blurRadius: 14)
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 12, right: 12, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getText(
                              title: "Total available points",
                              size: 13,
                              fontFamily: interMedium,
                              letterSpacing: 0.8,
                              color: ColorConstant.white,
                              fontWeight: FontWeight.w500),
                          const SizedBox(
                            height: 4,
                          ),
                          Center(
                            child: getText(
                                title: profileController.model != null &&
                                        profileController.model.value.data !=
                                            null &&
                                        profileController
                                                .model.value.data!.user !=
                                            null
                                    ? profileController
                                        .model.value.data!.user!.wallet
                                        .toString()
                                    : "0",
                                size: 22,
                                fontFamily: interSemiBold,
                                color: ColorConstant.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Get.to(
                            ExpertQrScreen(),
                            transition: Transition.cupertino,
                          )!
                              .then((value) {
                            controller.callApiFunction();
                            profileController.profileApiFunction();
                          });
                        },
                        child: Image.asset(
                          AppImages.qrExpert,
                          height: 44,
                          width: 44,
                        )),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: ColorConstant.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, -2),
                        color: ColorConstant.black3333.withOpacity(.2),
                        blurRadius: 10)
                  ]),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: getText(
                        title: "Recent Transaction",
                        size: 14,
                        fontFamily: poppinsMedium,
                        color: ColorConstant.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Obx(
                    () => controller.model!.value != null &&
                            controller.model!.value.data != null
                        ? Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: controller.model!.value.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {},
                                      child: walletTransaction(context, index));
                                }),
                          )
                        : Container(
                            height: 200,
                            alignment: Alignment.center,
                            child: noDataFound()),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  walletTransaction(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 6),
      child: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: 63,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  controller.model!.value.data![index].type != 'paid'
                      ? Image.asset(
                          width: 20, height: 20, AppImages.transcationIcon1)
                      : Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          child: Image.asset(
                            width: 12,
                            height: 12,
                            AppImages.transcationIcon2,
                          ),
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      controller.model!.value.data![index].titleMessage ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13.5,
                          fontFamily: poppinsMedium,
                          color: ColorConstant.blackColorDark,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  getText(
                      title: controller.model!.value.data![index].points ?? "",
                      size: 14,
                      fontFamily: poppinsMedium,
                      color: ColorConstant.blackColorDark,
                      fontWeight: FontWeight.w400),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 29),
                child: getText(
                    title: TimeFormat.currentTime(
                        controller.model!.value.data![index].createdAt),
                    size: 12,
                    fontFamily: poppinsRegular,
                    color: ColorConstant.hintColor,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 15,
                color: ColorConstant.dividerColor,
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

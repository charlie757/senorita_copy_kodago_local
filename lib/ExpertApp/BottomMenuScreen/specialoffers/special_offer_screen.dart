import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_dashboard_screen/controller/dashboard_controller.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/specialoffers/controller/special_offer_controller.dart';
import 'package:senorita/ScreenRoutes/routes.dart';
import 'package:senorita/helper/appbar.dart';
import 'package:senorita/helper/getText.dart';
import 'package:senorita/utils/color_constant.dart';
import 'package:senorita/utils/stringConstants.dart';
import 'package:senorita/widget/no_data_found.dart';

import '../../../helper/appimage.dart';
import '../../../utils/screensize.dart';
import '../../../utils/time_format.dart';

class SpecialOfferScreen extends GetView<SpecialOfferController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: specialOfferAppbar(context),
          body: Obx(() => controller.specialOfferModel.value != null &&
                  controller.specialOfferModel.value.offersList != null &&
                  controller.specialOfferModel.value.offersList!.isNotEmpty
              ? specialOfferWidget()
              : noDataFound())),
    );
  }

  addOfferWidget() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.addOfferScreen)?.then((value) {
          controller.allOffersApiFunction();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xffD9D9D9))),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: ColorConstant.homeExp,
              size: 15,
            ),
            getText(
                title: 'Add offer',
                size: 13,
                fontFamily: poppinsMedium,
                color: ColorConstant.homeExp,
                fontWeight: FontWeight.w400)
          ],
        ),
      ),
    );
  }

  specialOfferWidget() {
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return const SizedBox(
            height: 25,
          );
        },
        shrinkWrap: true,
        padding:
            const EdgeInsets.only(left: 15, right: 15, bottom: 50, top: 15),
        itemCount: controller.specialOfferModel.value.offersList!.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                color: ColorConstant.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: ColorConstant.borderColor),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, -2),
                      color: ColorConstant.blackColor.withOpacity(.2),
                      blurRadius: 15)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstant.white,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(18),
                        topLeft: Radius.circular(18)),
                    child: controller.specialOfferModel.value.offersList![index]
                                .banner !=
                            null
                        ? CachedNetworkImage(
                            height: 200,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            imageUrl:
                                "${controller.specialOfferModel.value.baseUrl}/${controller.specialOfferModel.value.offersList![index].banner}",
                            errorWidget: (context, url, error) => Image.network(
                              "https://raysensenbach.com/wp-content/uploads/2013/04/default.jpg",
                              height: 200,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          )
                        : Image.network(
                            "https://raysensenbach.com/wp-content/uploads/2013/04/default.jpg",
                            height: 200,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 11, right: 12, top: 8, bottom: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getText(
                          title: controller.specialOfferModel.value
                                      .offersList![index].type ==
                                  'discount'
                              ? "Flat ${controller.specialOfferModel.value.offersList![index].discountPecent.toString()}% Discount"
                              : "BUY 1 GET 1 FREE",
                          size: 14,
                          fontFamily: interSemiBold,
                          color: ColorConstant.black3333,
                          fontWeight: FontWeight.w600),
                      ScreenSize.height(4),
                      getText(
                          title: controller.specialOfferModel.value
                                  .offersList![index].description ??
                              "",
                          size: 12,
                          fontFamily: interMedium,
                          color: const Color(0xff7C7C7C),
                          fontWeight: FontWeight.w400),
                      ScreenSize.height(10),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.clockIcon,
                            height: 16,
                            width: 16,
                          ),
                          ScreenSize.width(7),
                          const getText(
                              title: 'Valid On - ',
                              size: 12,
                              fontFamily: interMedium,
                              color: Color(0xff707070),
                              fontWeight: FontWeight.w400),
                          getText(
                              title: controller.specialOfferModel.value
                                          .offersList![index].endDate !=
                                      null
                                  ? '${TimeFormat.convertInDate(controller.specialOfferModel.value.offersList![index].endDate)} at ${TimeFormat.convertInTimeWithAMPM(controller.specialOfferModel.value.offersList![index].endTime)}'
                                  : "",
                              size: 12,
                              fontFamily: interMedium,
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  AppBar specialOfferAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading: false,
      actions: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Get.find<ExpertDashboardController>().selectedIndex.value == 1
                  ? Container()
                  : GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        AppImages.backIcon,
                        height: 20,
                        width: 20,
                      )),
              ScreenSize.width(15),
              getText(
                  title: "Special Offer",
                  size: 17,
                  fontFamily: interSemiBold,
                  color: ColorConstant.blackColor,
                  fontWeight: FontWeight.w400),
              const Spacer(),
              addOfferWidget()
            ],
          ),
        ))
      ],
    );
  }
}

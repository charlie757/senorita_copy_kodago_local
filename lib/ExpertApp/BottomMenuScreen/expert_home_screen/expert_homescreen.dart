import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_home_screen/controller/expert_home_controller.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_qr_screen/expertQrScreen.dart';
import 'package:senorita/ScreenRoutes/routes.dart';
import 'package:senorita/api_config/Api_Url.dart';
import 'package:senorita/helper/network_image_helper.dart';
import 'package:senorita/widget/no_data_found.dart';
import '../../../UserApp/Salon_details_screen/ImgView.dart';
import '../../../helper/appimage.dart';
import '../../../helper/getText.dart';
import 'dart:math' as math;

import '../../../helper/searchbar.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/map_utils.dart';
import '../../../utils/screensize.dart';
import '../../../utils/stringConstants.dart';
import 'package:intl/intl.dart';
import '../../../utils/time_format.dart';
import '../expert_dashboard_screen/controller/dashboard_controller.dart';
import '../expert_profile_screen/controller/expert_profile_controller.dart';

class ExpertHomeScreen extends GetView<ExpertHomeController> {
  const ExpertHomeScreen({key});

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.put(ExpertDashboardController());
    return Scaffold(
      appBar: appBar(context, dashboardController),
      backgroundColor: ColorConstant.white,
      // drawer: drawer(context, controller),
      body: Obx(
        () => controller.isLoading.value
            ? Container()
            : SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 30, top: 15),
                child: Column(
                  children: [
                    Obx(() => controller.image.value.isNotEmpty
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            imageUrl: controller.image.value.toString(),
                            errorWidget: (context, url, error) => Image.network(
                              "https://raysensenbach.com/wp-content/uploads/2013/04/default.jpg",
                              fit: BoxFit.cover,
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                            ),
                          )
                        : Container()),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 0),
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1,
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Text(
                                      softWrap: true,
                                      controller.name.value.toString(),
                                      style: const TextStyle(
                                        fontSize: 19.0,
                                        letterSpacing: 0.6,
                                        fontFamily: interSemiBold,
                                        color: ColorConstant.blackColorDark,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => controller.subCategory.isNotEmpty
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: getText(
                                                title: controller.subCategory
                                                        .map((subcat) => subcat
                                                            .subCategoryName)
                                                        .join(', ') ??
                                                    '',
                                                size: 13.5,
                                                fontFamily: interMedium,
                                                color: ColorConstant.blackLight,
                                                fontWeight: FontWeight.w500),
                                          )
                                        : const SizedBox(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Exp. ",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: interMedium,
                                            color: ColorConstant.pointBg,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "${controller.experience.value.toString()} year in Business",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: interRegular,
                                            color: ColorConstant.blackLight,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  controller.status.value != ""
                                      ? Text(
                                          controller.status.value == "1"
                                              ? "Open Now"
                                              : "Close Now",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                            letterSpacing: .6,
                                            fontFamily: interMedium,
                                            color:
                                                controller.status.value == "1"
                                                    ? ColorConstant.greenColor
                                                    : ColorConstant.redColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 6, right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  controller.salonLat.value.isNotEmpty &&
                                          controller.salonLng.value.isNotEmpty
                                      ? MapUtils.openMap(
                                          double.parse(controller.salonLat.value
                                              .toString()),
                                          double.parse(controller.salonLng.value
                                              .toString()))
                                      : null;
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3),
                                          child: Image.asset(
                                            width: 16,
                                            height: 16,
                                            AppImages.location,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          padding: const EdgeInsets.only(
                                              right: 13.0),
                                          child: Text(
                                            softWrap: true,
                                            controller.location.value != 'null'
                                                ? controller.location.value
                                                : '',
                                            // overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 12.5,
                                              fontFamily: interMedium,
                                              color: ColorConstant.blackLight,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            controller.distance.value.toString() != ""
                                ? Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 2),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              width: 15,
                                              color: ColorConstant.greyColor,
                                              height: 15,
                                              AppImages.distance,
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.2,
                                              padding: const EdgeInsets.only(
                                                  right: 13.0),
                                              child: Text(
                                                " " +
                                                    controller.distance
                                                        .toString() +
                                                    " km",
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 13.0,
                                                  fontFamily: interMedium,
                                                  color:
                                                      ColorConstant.blackLight,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            controller.kodagoCard.value != ""
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        bottom: 1,
                                        top: 22),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                                AppRoutes.helpSupportScreen,
                                                arguments: [
                                                  'detail',
                                                  controller.kodagoCard.value
                                                ]);
                                          },
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const getText(
                                                    title: "Kodago Card",
                                                    size: 15,
                                                    fontFamily: interSemiBold,
                                                    color: ColorConstant
                                                        .blackColorDark,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                getText(
                                                    title: controller
                                                        .kodagoCard.value,
                                                    size: 13,
                                                    fontFamily: interMedium,
                                                    color: ColorConstant
                                                        .darkBlueColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            controller.spacialOffer.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 10, right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const getText(
                                            title: "Special offers",
                                            size: 15,
                                            fontFamily: interSemiBold,
                                            color: ColorConstant.blackColorDark,
                                            fontWeight: FontWeight.w600),
                                        ScreenSize.height(20),
                                        specialOffers(context)
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: SizedBox(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, bottom: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 2, bottom: 0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Obx(
                                                () => GestureDetector(
                                                  onTap: () {
                                                    controller.selectedTabValue
                                                        .value = 0;
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: getText(
                                                        title: "About Us",
                                                        size: 14,
                                                        fontFamily: interMedium,
                                                        color: controller
                                                                    .selectedTabValue
                                                                    .value ==
                                                                0
                                                            ? ColorConstant
                                                                .onBoardingBack
                                                            : ColorConstant
                                                                .qrViewText,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Obx(
                                                () => GestureDetector(
                                                  onTap: () {
                                                    controller.selectedTabValue
                                                        .value = 1;
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: getText(
                                                            title: "Menu",
                                                            size: 14,
                                                            fontFamily:
                                                                interMedium,
                                                            color: controller
                                                                        .selectedTabValue
                                                                        .value ==
                                                                    1
                                                                ? ColorConstant
                                                                    .onBoardingBack
                                                                : ColorConstant
                                                                    .qrViewText,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Obx(
                                                () => GestureDetector(
                                                  onTap: () {
                                                    controller.selectedTabValue
                                                        .value = 2;
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: getText(
                                                            title: "Review",
                                                            size: 14,
                                                            fontFamily:
                                                                interMedium,
                                                            color: controller
                                                                        .selectedTabValue
                                                                        .value ==
                                                                    2
                                                                ? ColorConstant
                                                                    .onBoardingBack
                                                                : ColorConstant
                                                                    .qrViewText,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Obx(
                                                () => GestureDetector(
                                                  onTap: () {
                                                    controller.selectedTabValue
                                                        .value = 3;
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: getText(
                                                            title: "Photos",
                                                            size: 14,
                                                            fontFamily:
                                                                interMedium,
                                                            color: controller
                                                                        .selectedTabValue
                                                                        .value ==
                                                                    3
                                                                ? ColorConstant
                                                                    .onBoardingBack
                                                                : ColorConstant
                                                                    .qrViewText,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.black12),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 15),
                                  child: tabViewData(context),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget tabViewData(BuildContext context) {
    return Obx(() => controller.selectedTabValue == 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getText(
                  lineHeight: 1.6,
                  title: controller.bio.value,
                  size: 12,
                  textAlign: TextAlign.left,
                  textOverflow: TextOverflow.visible,
                  fontFamily: interMedium,
                  color: ColorConstant.greyColor,
                  fontWeight: FontWeight.w500),
            ],
          )
        : controller.selectedTabValue == 1
            ? Obx(() => controller.getPriceList.isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, left: 0, right: 0),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    // padding: EdgeInsets.zero,
                    itemCount: controller.getPriceList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var priceListModel = controller.getPriceList[index];

                      // showToast(controller.getPriceList.toString());
                      //var model = controller.allWalletList[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 10),
                        child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              // Get.toNamed(AppRoutes.addPriceList);
                            },
                            child: menuUi(context, index)),
                      );
                    })
                : noDataFound())
            : controller.selectedTabValue == 2
                ? Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.averageRating.value != ""
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8, top: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const getText(
                                            lineHeight: 1.6,
                                            title: "Reviews & Ratings",
                                            size: 14,
                                            fontFamily: interMedium,
                                            color: ColorConstant.offerTextBlack,
                                            fontWeight: FontWeight.w600),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Obx(
                                          () => Row(
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                  color:
                                                      ColorConstant.greenReview,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 12,
                                                          bottom: 12),
                                                  child: getText(
                                                      title: controller
                                                              .avg_rating
                                                              .value
                                                              .isEmpty
                                                          ? '0.0'
                                                          : controller
                                                                  .avg_rating
                                                                  .value
                                                                  .toString()
                                                                  .contains('.')
                                                              ? controller
                                                                  .avg_rating
                                                                  .value
                                                                  .toString()
                                                              : "${controller.avg_rating.value.toString()}.0",
                                                      // controller.avg_rating.value
                                                      //     .toString(),
                                                      size: 15,
                                                      fontFamily: interMedium,
                                                      color:
                                                          ColorConstant.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  getText(
                                                      title: controller
                                                              .review_count
                                                              .value +
                                                          " Ratings",
                                                      size: 13,
                                                      fontFamily: interMedium,
                                                      color: ColorConstant
                                                          .blackColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  /* Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.4,
                                          child: getText(
                                              title:
                                                  "Kodago Business rating index based on 300 rating across",
                                              size: 12,
                                              fontFamily: interMedium,
                                              color: ColorConstant.qrViewText,
                                              fontWeight: FontWeight.w600),*/
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    padding:
                                                        new EdgeInsets.only(
                                                            right: 13.0),
                                                    child: Text(
                                                      softWrap: true,
                                                      "Kodago Business rating index based on 300 rating across",
                                                      // overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        fontFamily: interMedium,
                                                        color: ColorConstant
                                                            .greyColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    height: 1,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.black12),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: getText(
                                        lineHeight: 1.6,
                                        title: "User Reviews",
                                        size: 14,
                                        fontFamily: interSemiBold,
                                        color: ColorConstant.blackColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        padding:
                                            EdgeInsets.only(top: 0, bottom: 0),
                                        shrinkWrap: true,
                                        itemCount:
                                            controller.getRatingList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          //var model = controller.allWalletList[index];
                                          var model =
                                              controller.getRatingList[index];
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: 0.0, bottom: 10),
                                            child: GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: () {},
                                                child:
                                                    reviewUi(context, model)),
                                          );
                                        }),
                                  ),
                                ],
                              )
                            : noDataFound()
                      ],
                    ),
                  )
                : Obx(() => controller.photosList.isEmpty
                    ? noDataFound()
                    : GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 0),
                        itemCount: controller.photosList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 1,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, left: 3, right: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(
                                            ImgView(
                                                imgList: controller.photosList,
                                                index: index,
                                                route: "list"),
                                            transition: Transition.cupertino);
                                        // _showImageDialog(context,  ApiUrls.offerImageBase  + model.banner);
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorConstant.addMoney),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              ApiUrls.expertImageBase +
                                                  controller.photosList[index],
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          // border:
                                          //     Border.all(color: Theme.of(context).accentColor),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )));
  }

  Widget menuUi(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          controller.getPriceList[index]['name'],
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13.0,
            fontFamily: interMedium,
            color: ColorConstant.offerTextBlack,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 0,
        ),
        ListView.builder(
            itemCount: controller.getPriceList[index]['data'].length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const ScrollPhysics(),
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.circle,
                      color: ColorConstant.appColor,
                      size: 10,
                    ),
                    // Image.asset(
                    //   width: 18,
                    //   height: 18,
                    //   AppImages.menuImg,
                    // ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        controller.getPriceList[index]['data'][i]['item_name'],
                        //  priceListModel['Bridal/Groom Packages'][0]['item_name'].toString(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: interMedium,
                          color: ColorConstant.qrViewText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // const Spacer(),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        "₹ ${controller.getPriceList[index]['data'][i]['price'].toString()}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: interMedium,
                          color: ColorConstant.offerTextBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })
      ],
    );
  }

  Widget reviewUi(BuildContext context, model) {
    DateTime dateTime = DateTime.parse(model.created_at).toLocal();
    String formattedDateTime = DateFormat.yMd().add_jm().format(dateTime);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /*ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset(
                  item.image,
                  width: 45.0,
                  height: 45.0,
                  fit: BoxFit.fill,
                ),
              ),*/

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: interMedium,
                      color: ColorConstant.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        formattedDateTime.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11.0,
                          fontFamily: interMedium,
                          color: ColorConstant.qrViewText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              model.rating != ""
                  ? Container(
                      decoration: BoxDecoration(
                          color: ColorConstant.greenColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: ColorConstant.greenColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Row(
                          children: [
                            getText(
                                title: model.rating == null
                                    ? '0.0'
                                    : model.rating.toString().contains('.')
                                        ? model.rating.toString()
                                        : "${model.rating.toString()}.0",
                                size: 12,
                                fontFamily: interMedium,
                                color: ColorConstant.white,
                                fontWeight: FontWeight.w500),
                            const SizedBox(
                              width: 2,
                            ),
                            Image.asset(
                              width: 9,
                              height: 9,
                              color: ColorConstant.white,
                              AppImages.rating,
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 1.1,
          ),
          child: Text(
            model.review,
            style: const TextStyle(
              fontSize: 12.0,
              fontFamily: interMedium,
              letterSpacing: 0.4,
              color: ColorConstant.qrViewText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: 0,
        ),
        const Padding(
          padding: EdgeInsets.only(right: 13, bottom: 0),
          child: Row(
            children: [
              Text(
                "",
                style: TextStyle(
                  fontSize: 13.0,
                  fontFamily: interMedium,
                  letterSpacing: 0.4,
                  color: ColorConstant.qrViewText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: ColorConstant.fitterLine),
        ),
      ],
    );
  }

  Widget specialOffers(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return const SizedBox(
            height: 25,
          );
        },
        itemCount: controller.spacialOffer.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
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
                      child: controller.spacialOffer[index]['banner'] != null
                          ? NetworkImageHelper(
                              img:
                                  "${controller.offersUrl}/${controller.spacialOffer[index]['banner']}",
                              height: 200.0,
                              width: double.infinity,
                            )
                          : Container()),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 11, right: 12, top: 8, bottom: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getText(
                          title: controller.spacialOffer[index]['type'] ==
                                  'discount'
                              ? "Flat ${controller.spacialOffer[index]['discount_pecent'].toString()}% Discount"
                              : "BUY 1 GET 1 FREE".toString().toUpperCase(),
                          size: 14,
                          fontFamily: interSemiBold,
                          color: ColorConstant.black3333,
                          fontWeight: FontWeight.w600),
                      ScreenSize.height(4),
                      getText(
                          title: controller.spacialOffer[index]
                                  ['description'] ??
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
                              title: 'Valid Till - ',
                              size: 12,
                              fontFamily: interMedium,
                              color: Color(0xff707070),
                              fontWeight: FontWeight.w400),
                          getText(
                              title: controller.spacialOffer[index]
                                          ['end_date'] !=
                                      null
                                  ? '${TimeFormat.convertInDate(controller.spacialOffer[index]['end_date'])} at ${TimeFormat.convertInTimeWithAMPM(controller.spacialOffer[index]['end_time'])}'
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

  AppBar appBar(
      BuildContext context, ExpertDashboardController dashboardController) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: ColorConstant.white,
      automaticallyImplyLeading: false,
      actions: [
        Obx(() => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    dashboardController.expertProfileController.model != null &&
                            dashboardController.expertProfileController.model
                                    .value!.data !=
                                null &&
                            dashboardController.expertProfileController.model!
                                    .value.data!.user !=
                                null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: NetworkImageHelper(
                              img: ApiUrls.imgBaseUrl +
                                  dashboardController.expertProfileController
                                      .model!.value.data!.user!.profilePicture
                                      .toString(),
                              width: 50.0,
                              height: 50.0,
                            ),
                          )
                        : Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: ColorConstant.greyColor.withOpacity(.3),
                                shape: BoxShape.circle),
                            child: const Icon(
                              Icons.person,
                              size: 28,
                            ),
                          ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              dashboardController
                                              .expertProfileController.model !=
                                          null &&
                                      dashboardController
                                              .expertProfileController
                                              .model
                                              .value!
                                              .data !=
                                          null &&
                                      dashboardController
                                              .expertProfileController
                                              .model!
                                              .value
                                              .data!
                                              .user !=
                                          null
                                  ? dashboardController.expertProfileController
                                      .model!.value.data!.user!.name
                                      .toString()
                                  : "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: interMedium,
                                color: ColorConstant.blackColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: Obx(
                                () => Row(
                                  children: [
                                    Obx(() => Transform.scale(
                                          scale: 0.8,
                                          child: Switch(
                                            value: dashboardController
                                                .isSwitched.value,
                                            activeColor:
                                                ColorConstant.onBoardingBack,
                                            onChanged: (value) {
                                              dashboardController
                                                  .expertUpdateApiFunction(
                                                      context);
                                            },
                                          ),
                                        )),
                                    getText(
                                        title: dashboardController
                                                    .isSwitched.value ==
                                                false
                                            ? "Not Available"
                                            : "Available",
                                        size: 12,
                                        fontFamily: interRegular,
                                        color: ColorConstant.greyColor,
                                        fontWeight: FontWeight.w400)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.notificationScreen, parameters: {
                          'userId': Get.find<ExpertProfileController>()
                              .model
                              .value
                              .data!
                              .user!
                              .id
                              .toString()
                        });
                      },
                      child: Center(
                        child: Image.asset(
                          height: 23,
                          width: 23,
                          // color: Colors.black87,
                          AppImages.notificationHome,
                        ),
                      ),
                    ),
                    ScreenSize.width(10),
                    GestureDetector(
                        onTap: () {
                          Get.to(ExpertQrScreen(),
                              transition: Transition.cupertino);
                        },
                        child: Image.asset(
                          AppImages.qrExpert,
                          height: 30,
                          width: 30,
                        ))
                  ],
                ),
              ),
            )),
      ],
    );
  }
}

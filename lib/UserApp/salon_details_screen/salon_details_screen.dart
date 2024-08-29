import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senorita/utils/extension.dart';
import 'package:senorita/utils/screensize.dart';
import 'package:senorita/utils/time_format.dart';
import 'package:senorita/widget/no_data_found.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../ScreenRoutes/routes.dart';
import '../../api_config/Api_Url.dart';
import '../../helper/appimage.dart';
import '../../helper/getText.dart';
import '../../utils/color_constant.dart';
import '../../utils/map_utils.dart';
import '../../utils/stringConstants.dart';
import '../../utils/toast.dart';
import 'ImgView.dart';
import 'controller/salon_details_controller.dart';

class SalonDetailScreen extends GetView<SalonDetailController> {
  const SalonDetailScreen({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => controller.isLoading.value
              ? Container()
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Obx(() => GestureDetector(
                                onTap: () {
                                  if (controller.image.value.isNotEmpty) {
                                    Get.to(
                                        ImgView(
                                          imgList: [],
                                          img: controller.image.value,
                                          index: 0,
                                          route: 'single',
                                        ),
                                        transition: Transition.cupertino);
                                  }
                                },
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  imageUrl: controller.image.value.toString(),
                                  errorWidget: (context, url, error) =>
                                      Image.network(
                                    "https://raysensenbach.com/wp-content/uploads/2013/04/default.jpg",
                                    fit: BoxFit.cover,
                                    height: 250,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              )),
                          Card(
                            margin: EdgeInsets.zero,
                            color: Colors.white,
                            // elevation: 3,
                            elevation: 0,
                            // shadowColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                              //set border radius more than 50% of height and width to make circle
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 0),
                              child: Obx(
                                () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1,
                                            padding: const EdgeInsets.only(
                                                right: 12.0),
                                            child: Text(
                                              softWrap: true,
                                              controller.name.value
                                                  .toString()
                                                  .toTitleCase(),
                                              style: const TextStyle(
                                                fontSize: 19.0,
                                                letterSpacing: 0.6,
                                                fontFamily: interSemiBold,
                                                color: ColorConstant
                                                    .blackColorDark,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Obx(
                                            () => controller
                                                    .subCategory.isNotEmpty
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    child: getText(
                                                        title: controller
                                                                .subCategory
                                                                .map((subcat) =>
                                                                    subcat
                                                                        .subCategoryName)
                                                                .join(', ') ??
                                                            '',
                                                        size: 12.5,
                                                        fontFamily: interMedium,
                                                        color: ColorConstant
                                                            .blackLight,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                : const SizedBox(),
                                          ),
                                          controller.experience.value.isEmpty
                                              ? Container()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8),
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        "Exp. ",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 13.0,
                                                          fontFamily:
                                                              interMedium,
                                                          color: ColorConstant
                                                              .pointBg,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${controller.experience.value.toString()} year in Business",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 13.0,
                                                          fontFamily:
                                                              interRegular,
                                                          color: ColorConstant
                                                              .blackLight,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          controller.status.value != ""
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  child: Text(
                                                    controller.status.value ==
                                                            "1"
                                                        ? "Open Now"
                                                        : "Close Now",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontFamily: interMedium,
                                                      color: controller.status
                                                                  .value ==
                                                              "1"
                                                          ? ColorConstant
                                                              .greenColor
                                                          : ColorConstant
                                                              .redColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, right: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.salonLat.value
                                                      .isNotEmpty &&
                                                  controller
                                                      .salonLng.value.isNotEmpty
                                              ? MapUtils.openMap(
                                                  double.parse(controller
                                                      .salonLat.value
                                                      .toString()),
                                                  double.parse(controller
                                                      .salonLng.value
                                                      .toString()))
                                              : null;
                                        },
                                        child: controller.location.value.isEmpty
                                            ? Container()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      width: 16,
                                                      height: 16,
                                                      AppImages.location,
                                                    ),
                                                    const SizedBox(
                                                      width: 2,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        controller.location
                                                                    .value !=
                                                                'null'
                                                            ? controller
                                                                .location.value
                                                            : '',
                                                        // overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 12.5,
                                                          fontFamily:
                                                              interMedium,
                                                          color: ColorConstant
                                                              .blackLight,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ),
                                    ),
                                    controller.distance.value.toString() != ""
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 8),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      width: 15,
                                                      color: ColorConstant
                                                          .greyColor,
                                                      height: 15,
                                                      AppImages.distance,
                                                    ),
                                                    const SizedBox(
                                                      width: 3,
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.2,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 13.0),
                                                      child: Text(
                                                        " " +
                                                            controller.distance
                                                                .toString() +
                                                            " km",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 13.0,
                                                          fontFamily:
                                                              interMedium,
                                                          color: ColorConstant
                                                              .blackLight,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                                        AppRoutes
                                                            .helpSupportScreen,
                                                        arguments: [
                                                          'detail',
                                                          controller
                                                              .kodagoCard.value
                                                        ]);
                                                  },
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const getText(
                                                            title:
                                                                "Kodago Card",
                                                            size: 15,
                                                            fontFamily:
                                                                interSemiBold,
                                                            color: ColorConstant
                                                                .blackColorDark,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                        const SizedBox(
                                                          height: 7,
                                                        ),
                                                        getText(
                                                            title: controller
                                                                .kodagoCard
                                                                .value,
                                                            size: 13,
                                                            fontFamily:
                                                                interMedium,
                                                            color: ColorConstant
                                                                .darkBlueColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
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
                                                    color: ColorConstant
                                                        .blackColorDark,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                            left: 5,
                                            right: 5,
                                          ),
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
                                                            controller
                                                                .selectedTabValue
                                                                .value = 0;
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: getText(
                                                                title:
                                                                    "About Us",
                                                                size: 14,
                                                                fontFamily:
                                                                    interMedium,
                                                                color: controller
                                                                            .selectedTabValue.value ==
                                                                        0
                                                                    ? ColorConstant
                                                                        .onBoardingBack
                                                                    : ColorConstant
                                                                        .qrViewText,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Obx(
                                                        () => GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .selectedTabValue
                                                                .value = 1;
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: getText(
                                                                    title:
                                                                        "Menu",
                                                                    size: 14,
                                                                    fontFamily:
                                                                        interMedium,
                                                                    color: controller.selectedTabValue.value ==
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
                                                            controller
                                                                .selectedTabValue
                                                                .value = 2;
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: getText(
                                                                    title:
                                                                        "Review",
                                                                    size: 14,
                                                                    fontFamily:
                                                                        interMedium,
                                                                    color: controller.selectedTabValue.value ==
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
                                                            controller
                                                                .selectedTabValue
                                                                .value = 3;
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: getText(
                                                                    title:
                                                                        "Photos",
                                                                    size: 14,
                                                                    fontFamily:
                                                                        interMedium,
                                                                    color: controller.selectedTabValue.value ==
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
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
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 45,
                        left: 5,
                      ),
                      child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstant.white,
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, -2),
                                      color: ColorConstant.blackColor
                                          .withOpacity(.2),
                                      blurRadius: 10)
                                ]),
                            child: Image.asset(
                              AppImages.backIcon,
                              height: 20,
                              width: 20,
                              color: ColorConstant.appColor,
                            ),
                          )),
                    ),
                  ],
                ),
        ),
        bottomNavigationBar: Obx(
          () => controller.isLoading.value
              ? const SizedBox(
                  height: 0,
                )
              : Container(
                  height: 55,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, -1),
                        color: ColorConstant.blackColor.withOpacity(.1),
                        blurRadius: 10)
                  ]),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 0,
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 8, bottom: 0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    backgroundColor:
                                        ColorConstant.onBoardingBack,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                onPressed: () {
                                  var phoneNumber =
                                      controller.mobile.value.toString();
                                  controller.status == 1.toString()
                                      ? _makePhoneCall(phoneNumber)
                                      : showToast("Expert is not Available");
                                },
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        width: 15,
                                        height: 15,
                                        AppImages.callDetails,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      getText(
                                          title: "Call Now",
                                          size: 13,
                                          fontFamily: interSemiBold,
                                          color: ColorConstant.white,
                                          fontWeight: FontWeight.w500),
                                    ],
                                  ),
                                ),
                              )),
                              const SizedBox(
                                width: 35,
                              ),
                              Expanded(
                                  child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    backgroundColor:
                                        ColorConstant.onBoardingBack,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                onPressed: () {
                                  controller
                                      .openWhatsapp(controller.mobile.value);
                                },
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        width: 15,
                                        height: 15,
                                        AppImages.messageDetails,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      getText(
                                          title: "Chat",
                                          size: 13,
                                          fontFamily: interSemiBold,
                                          color: ColorConstant.white,
                                          fontWeight: FontWeight.w600),
                                    ],
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ));
  }

  Widget tabViewData(BuildContext context) {
    print(controller.getPriceList.length);
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
                : Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: noDataFound(),
                  ))
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
                                        SizedBox(
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
                            : Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: noDataFound(title: "No Reviews")),
                        ScreenSize.height(15),
                        writeReviewBtn(context),
                      ],
                    ),
                  )
                : Obx(() => controller.photosList.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: noDataFound(),
                      )
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
                          // var model = controller.photosList[index];
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
                                              route: 'list',
                                            ),
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
                    /*Text(
                      controller.getPriceList[index]['data'][i]['item_name'],
                      //  priceListModel['Bridal/Groom Packages'][0]['item_name'].toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontFamily: interMedium,
                        color: ColorConstant.qrViewText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),*/
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
                  SizedBox(
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
                  ? /*Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: ColorConstant.greenStar,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 9, bottom: 9),
                        child: Row(
                          children: [
                            getText(
                                title: model.rating + ".0",
                                size: 15,
                                fontFamily: interMedium,
                                color: ColorConstant.white,
                                fontWeight: FontWeight.w500),
                            SizedBox(
                              width: 6,
                            ),
                            Image.asset(
                              AppImages.reviewStar,
                              width: 12.0,
                              height: 12.0,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                    )*/
                  Container(
                      decoration: BoxDecoration(
                          color: ColorConstant.greenColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
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
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 1.1,
          ),
          child: Text(
            model.review,
            style: TextStyle(
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
        Padding(
          padding: const EdgeInsets.only(right: 13, bottom: 0),
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
              /* Spacer(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.reportScreen);
                },
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: ColorConstant.fitterLine)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 13, right: 13, top: 9, bottom: 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getText(
                            title: "Report",
                            size: 13,
                            fontFamily: interMedium,
                            color: ColorConstant.qrViewText,
                            fontWeight: FontWeight.w500),
                      ],
                    ),
                  ),
                ),
              ),*/
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
            height: 20,
          );
        },
        itemCount: controller.spacialOffer.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 15),
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
                        ? CachedNetworkImage(
                            height: 200,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            imageUrl:
                                "${controller.offersUrl}/${controller.spacialOffer[index]['banner']}",
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
                          title: controller.spacialOffer[index]['type'] ==
                                  'discount'
                              ? "Flat ${controller.spacialOffer[index]['discount_pecent'].toString()}% Discount"
                              : "BUY 1 GET 1 FREE",
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

  Widget writeReviewBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.userRating = '';
        controller.myRating.value.isEmpty
            ? ratingUi(context)
            : showToast('Already reviewed');
      },
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ColorConstant.white,
              border: Border.all(
                color: ColorConstant.appColor,
              )),
          alignment: Alignment.center,
          child: getText(
              title: 'Write a review',
              size: 13,
              fontFamily: interMedium,
              color: ColorConstant.appColor,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  void ratingUi(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        enableDrag: true,
        builder: (builder) {
          return StatefulBuilder(builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.reviewController.text = "";
                        Navigator.pop(context, true);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8)),
                        child: Image.asset(
                          height: 35,
                          width: 35,
                          AppImages.crossBtn,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))
                          //set border radius more than 50% of height and width to make circle
                          ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: getText(
                                  title: "Write a Review",
                                  size: 17,
                                  fontFamily: interRegular,
                                  color: ColorConstant.blackColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: getText(
                                      title:
                                          "How would you rate your experience?",
                                      size: 12,
                                      fontFamily: interRegular,
                                      color: ColorConstant.offerTextBlack,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                /*RatingBarIndicator(
                                      rating: 2.5,
                                      itemCount: 5,
                                      itemSize: 30.0,
              
                                      itemBuilder: (context, _) => const Icon(
                                            Icons.star,
                                            color: Colors.red,
                                          )),*/
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: 0,
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      itemSize: 25,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 0.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        controller.userRating =
                                            rating.toString();
                                        state(() {});
                                      },
                                    ),
                                    ScreenSize.width(10),
                                    getText(
                                        title: controller.userRating == '1.0'
                                            ? 'Poor'
                                            : controller.userRating == '2.0'
                                                ? 'Average'
                                                : controller.userRating == '3.0'
                                                    ? "Good"
                                                    : controller.userRating ==
                                                            '4.0'
                                                        ? "Very Good"
                                                        : controller.userRating ==
                                                                '5.0'
                                                            ? "Excellent"
                                                            : "",
                                        size: 12,
                                        fontFamily: interRegular,
                                        color: ColorConstant.appColor,
                                        fontWeight: FontWeight.w600),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: getText(
                                      title: "Tell us about your experience",
                                      size: 12,
                                      fontFamily: interRegular,
                                      color: ColorConstant.offerTextBlack,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, right: 7),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    // <-- TextField width// <-- TextField height
                                    child: TextField(
                                      controller: controller.reviewController,
                                      maxLines: 10,
                                      minLines: 1,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(fontSize: 12),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        fillColor: Colors.white,
                                        hintStyle: TextStyle(
                                            color: ColorConstant.greyColor,
                                            fontSize: 12),
                                        hintText: 'Enter Review',
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, top: 7, bottom: 8),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  if (controller.userRating == "") {
                                    showToast("Rating Is Required");
                                  } else if (controller.reviewController.text ==
                                      "") {
                                    showToast("Review Is Required");
                                  } else {
                                    controller.submitReviewApiFunction(context);
                                    Navigator.pop(context);
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, top: 13, bottom: 13),
                                  decoration: BoxDecoration(
                                      color: ColorConstant.onBoardingBack,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7))),
                                  child: Center(
                                    child: getText(
                                        title: "Apply",
                                        size: 17,
                                        fontFamily: interRegular,
                                        color: ColorConstant.white,
                                        fontWeight: FontWeight.w100),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}

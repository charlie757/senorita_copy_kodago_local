import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:senorita/UserApp/BottomMenuScreen/home_screen/shimmer/all_expert_shimmer.dart';
import 'package:senorita/UserApp/BottomMenuScreen/profile_screen/controller/profile_controller.dart';
import 'package:senorita/api_config/Api_Url.dart';
import 'package:senorita/helper/custombtn.dart';
import 'package:senorita/helper/network_image_helper.dart';
import 'package:senorita/utils/screensize.dart';
import 'package:senorita/widget/no_data_found.dart';
import 'package:senorita/widget/view_salon_widget.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../helper/appimage.dart';
import '../../../helper/getText.dart';
import '../../../helper/searchbar.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/stringConstants.dart';
import '../../../widget/banner_indicator.dart';
import '../dashboard_screen/controller/dashboard_controller.dart';

class HomeScreen extends GetView<DashboardController> {
  const HomeScreen({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, () => null),
      backgroundColor: ColorConstant.white,
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 5),
              child: searchBar(
                  readOnly: true,
                  onTap: () {
                    Get.toNamed(AppRoutes.searchScreen);
                  }),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Slider
                  Obx(
                    () => controller.homeModel.value != null &&
                            controller.homeModel.value.data != null &&
                            controller.homeModel.value.data!.getFeatureOffer !=
                                null &&
                            controller.homeModel.value.data!.getFeatureOffer!
                                .isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 9, right: 9, top: 20),
                            child: Obx(
                              () => controller.isLoading.value &&
                                      controller.homeModel == null
                                  ? homeScreenShimmer()
                                  : SizedBox(
                                      child: CarouselSlider(
                                        items: <Widget>[
                                          for (var i = 0;
                                              i <
                                                  controller
                                                      .homeModel
                                                      .value
                                                      .data!
                                                      .getFeatureOffer!
                                                      .length;
                                              i++)
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: NetworkImageHelper(
                                                img:
                                                    "${controller.homeModel.value.data!.offerBaseUrl.toString()}/${controller.homeModel.value.data!.getFeatureOffer![i].banner}",
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              ),
                                            ),
                                        ],
                                        options: CarouselOptions(
                                            height: 200.0,
                                            enlargeCenterPage: true,
                                            autoPlay: controller
                                                        .homeModel
                                                        .value
                                                        .data!
                                                        .getFeatureOffer!
                                                        .length >
                                                    1
                                                ? true
                                                : false,
                                            aspectRatio: 16 / 9,
                                            scrollPhysics: controller
                                                        .homeModel
                                                        .value
                                                        .data!
                                                        .getFeatureOffer!
                                                        .length >
                                                    1
                                                ? const ScrollPhysics()
                                                : const NeverScrollableScrollPhysics(),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enableInfiniteScroll: true,
                                            autoPlayAnimationDuration:
                                                const Duration(
                                                    milliseconds: 500),
                                            viewportFraction: 1,
                                            onPageChanged: (val, _) {
                                              controller.bannerIndex.value =
                                                  val;
                                            }),
                                      ),
                                    ),
                            ))
                        : const SizedBox(),
                  ),
                  Obx(
                    () => controller.homeModel != null &&
                            controller.homeModel.value.data != null &&
                            controller.homeModel.value.data!.getFeatureOffer !=
                                null &&
                            controller.homeModel.value.data!.getFeatureOffer!
                                    .length >
                                1
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    controller.homeModel.value.data!
                                        .getFeatureOffer!.length, (index) {
                                  return controller.bannerIndex.value == index
                                      ? bannerIndicator(true)
                                      : bannerIndicator(false);
                                })),
                          )
                        : Container(),
                  ),
                  //All Expertise
                  // all category
                  categoryWidget(),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 12, left: 12, top: 15),
                    child: getText(
                        title: "Top Rated Business",
                        size: 16,
                        fontFamily: interSemiBold,
                        color: ColorConstant.blackColor,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  controller.homeModel != null &&
                          controller.homeModel.value.data != null &&
                          controller.homeModel.value.data!.topRatedListing !=
                              null
                      ? ListView.separated(
                          separatorBuilder: (context, sp) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          padding: const EdgeInsets.only(
                              left: 15, right: 14, bottom: 30),
                          shrinkWrap: true,
                          itemCount: controller
                              .homeModel.value.data!.topRatedListing!.length,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            var model = controller
                                .homeModel.value.data!.topRatedListing![index];
                            return Column(
                              children: [
                                salonWidget(context, model, 'home', () {
                                  Get.toNamed(AppRoutes.salonDetailsScreen,
                                      arguments: [
                                        model.user!.id.toString(),
                                        controller.lat.toString(),
                                        controller.long.toString(),
                                      ]);
                                }),
                                controller.homeModel.value.data!
                                                .topRatedListing!.length -
                                            1 ==
                                        index
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: CustomBtn(
                                            title: 'Show more Business',
                                            height: 40,
                                            width: double.infinity,
                                            onTap: () {
                                              Get.toNamed(
                                                  AppRoutes
                                                      .singleCategoryListScreen,
                                                  arguments: ['', '']);
                                            },
                                            color: ColorConstant.appColor),
                                      )
                                    : Container()
                              ],
                            );
                          })
                      : Container(
                          height: 200,
                          alignment: Alignment.center,
                          child: noDataFound(title: "No Business Available"),
                        ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget seeMoreBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.singleCategoryListScreen, arguments: ['', '']);
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
            padding: const EdgeInsets.only(right: 10, left: 10),
            alignment: Alignment.center,
            child: Row(
              children: [
                const Spacer(),
                getText(
                    title: 'See More',
                    size: 13,
                    fontFamily: interMedium,
                    color: ColorConstant.appColor,
                    fontWeight: FontWeight.w500),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: ColorConstant.appColor,
                  size: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context, Function() onTap) {
    return AppBar(
      backgroundColor: ColorConstant.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0.0,
      actions: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 15),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.changeLocationScreen)?.then((value) {
                  print("value...$value");
                  if (value != null) {
                    controller.allHomeScreenApiFunction(
                        value[0]['lat'], value[0]['lng'], '', true);
                  }
                });
              },
              child: Row(
                children: [
                  Image.asset(
                    AppImages.homeLocationIcon,
                    height: 30,
                    width: 30,
                    color: ColorConstant.appColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    controller.subLocality.value.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: interBold,
                                        color: ColorConstant.blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  AppImages.dropdown,
                                  width: 11,
                                  height: 6,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            getText(
                                title: controller.address.value.toString(),
                                size: 10,
                                fontFamily: interLight,
                                letterSpacing: .3,
                                lineHeight: 1.4,
                                textOverflow: TextOverflow.ellipsis,
                                color: ColorConstant.black3333,
                                fontWeight: FontWeight.w600),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 21, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.walletScreen);
                },
                child: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: ColorConstant.appColor.withOpacity(.5))),
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 10, right: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          height: 22,
                          width: 22,
                          AppImages.walletIcon,
                          // color: Colors.black87,
                        ),
                        ScreenSize.width(5),
                        getText(
                            title:
                                Get.find<ProfileController>().model != null &&
                                        Get.find<ProfileController>()
                                                .model
                                                .value
                                                .data !=
                                            null
                                    ? Get.find<ProfileController>()
                                            .model
                                            .value
                                            .data!
                                            .wallet ??
                                        "0"
                                    : "0",
                            size: 13,
                            fontFamily: interMedium,
                            color: ColorConstant.black3333,
                            fontWeight: FontWeight.w600)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.notificationScreen, parameters: {
                    'userId': controller.profileController.model.value.data!.id
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
            ],
          ),
        )
      ],
      centerTitle: true,
    );
  }

  categoryWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 13),
            child: Text(
              'Popular Category',
              style: TextStyle(
                  fontSize: 16,
                  color: ColorConstant.black3333,
                  fontWeight: FontWeight.w500,
                  fontFamily: interSemiBold),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          controller.categoryModel.value != null &&
                  controller.categoryModel.value!.data != null
              ? SingleChildScrollView(
                  child: SizedBox(
                    height: 116,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            controller.categoryModel.value!.data!.length,
                            (index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.singleCategoryListScreen,
                                  arguments: [
                                    controller
                                        .categoryModel.value!.data![index].id
                                        .toString(),
                                    controller
                                        .categoryModel.value!.data![index].name
                                        .toString()
                                  ]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6, right: 6),
                              child: Container(
                                height: 100,
                                width: 90,
                                decoration: BoxDecoration(
                                    color: ColorConstant.white,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, -1),
                                          blurRadius: 10,
                                          color: ColorConstant.blackColor
                                              .withOpacity(.2))
                                    ]),
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    NetworkImageHelper(
                                      img:
                                          "${controller.categoryModel.value!.data![index].imgUrl}",
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      controller.categoryModel.value!
                                              .data![index].name ??
                                          '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: ColorConstant.blackColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: interMedium),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

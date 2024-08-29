import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:senorita/UserApp/BottomMenuScreen/offers_screen/controller/offers_controller.dart';
import 'package:senorita/UserApp/salon_details_screen/controller/salon_details_controller.dart';
import 'package:senorita/helper/appbar.dart';
import 'package:senorita/utils/screensize.dart';
import 'package:senorita/widget/no_data_found.dart';
import 'package:senorita/widget/view_salon_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../helper/appimage.dart';
import '../../../helper/getText.dart';
import '../../../helper/searchbar.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/my_sperator.dart';
import '../../../utils/size_config.dart';
import '../../../utils/stringConstants.dart';
import '../home_screen/shimmer/all_expert_shimmer.dart';

class OffersScreen extends GetView<OffersController> {
  const OffersScreen({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.white,
      appBar:
          appBar(context, 'Special Offer', () => null, isShowLeading: false),
      body: RefreshIndicator(
        onRefresh: () => controller.allOffersApiFunction(false),
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollStartNotification) {
            } else if (scrollNotification is ScrollUpdateNotification) {
            } else if (scrollNotification is ScrollEndNotification) {
              if (scrollNotification.metrics.pixels >=
                  scrollNotification.metrics.maxScrollExtent - 40) {
                controller.allOffersPaginationApiFunction();
              }
            }
            return true;
          },
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: searchBar(
                                readOnly: true,
                                onTap: () {
                                  Get.toNamed(AppRoutes.searchScreen);
                                })),
                        ScreenSize.width(10),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.filterScreen, arguments: [
                              "offer",
                              '',
                              '',
                              controller.savedFilterValues
                            ])?.then((value) {
                              print(value);
                              if (value != null) {
                                controller.hasOffer.value =
                                    value['offer'].toString();
                                controller.category.value =
                                    value['category'].toString();
                                controller.subCategory.value =
                                    value['subcat'].toString();
                                controller.price.value =
                                    value['price'].toString();
                                controller.discount.value =
                                    value['discount'].toString();
                                controller.rating.value =
                                    value['topRated'].toString().isNotEmpty
                                        ? value['topRated'].toString()
                                        : value['rating'] == 0
                                            ? ''
                                            : value['rating'].toString();
                                controller.distance.value =
                                    value['distance'].isEmpty
                                        ? ''
                                        : "0-${value['distance'].toString()}";
                                controller.newArrivals.value =
                                    value['arrivals'].toString();
                                controller.savedFilterValues = {
                                  'hasOffer': controller.hasOffer.value,
                                  'category': controller.category.value,
                                  'subcat': controller.subCategory.value,
                                  'price': controller.price.value,
                                  'discount': controller.discount.value,
                                  'topRated': value['topRated'],
                                  'rating': value['rating'],
                                  'distance': value['distance'],
                                  'arrivals': value['arrivals']
                                };

                                print("vbbb..${controller.savedFilterValues}");
                                controller.allOffersApiFunction(true);
                              }
                            });
                          },
                          child: Container(
                            height: 49,
                            width: 49,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color(0xffD9D9D9))),
                            alignment: Alignment.center,
                            child: Image.asset(
                              AppImages.filterIcon,
                              height: 20,
                              width: 20,
                              color: Color(0xff767676),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ScreenSize.height(5),
                  Expanded(
                    child: Container(
                        color: ColorConstant.white,
                        child: Obx(() => controller.isLoading.value
                            ? allExpertShimmer()
                            : controller.allOffersList.value.isNotEmpty
                                ? SizedBox(
                                    child: ListView.separated(
                                        separatorBuilder: (context, sp) {
                                          return const SizedBox(
                                            height: 20,
                                          );
                                        },
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 14,
                                            top: 15,
                                            bottom: 40),
                                        itemCount: controller
                                            .allOffersList.value.length,
                                        physics: const ScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var model =
                                              controller.allOffersList[index];
                                          return salonWidget(
                                              context, model, 'offer', () {
                                            Get.toNamed(
                                                AppRoutes.salonDetailsScreen,
                                                arguments: [
                                                  model.userId,
                                                  controller.latitude
                                                      .toString(),
                                                  controller.longitude
                                                      .toString()
                                                ]);
                                            final categoryController = Get.put(
                                                SalonDetailController());
                                            categoryController
                                                    .categoryId.value =
                                                model.userId.toString();
                                            categoryController.lat.value =
                                                controller.latitude.toString();
                                            controller.longitude.toString();
                                            categoryController.onInit();
                                          });
                                        }),
                                  )
                                : noDataFound())),
                  ),
                  controller.isLoadMoreRunning.value == true
                      ? const Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: Center(child: CircularProgressIndicator()))
                      : Container(),
                  controller.hasNextPage.value == false
                      ? const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 40),
                          child: Center(child: Text("no data")))
                      : Container(),
                ],
              )),
        ),
      ),
    );
  }
}

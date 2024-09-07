import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:senorita/UserApp/BottomMenuScreen/home_screen/shimmer/all_expert_shimmer.dart';
import 'package:senorita/UserApp/BottomMenuScreen/single_category_list_screen/controller/single_category_list_controller.dart';
import 'package:senorita/helper/getText.dart';
import 'package:senorita/utils/screensize.dart';
import 'package:senorita/utils/stringConstants.dart';
import 'package:senorita/widget/no_data_found.dart';
import 'package:senorita/widget/view_salon_widget.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../helper/appbar.dart';
import '../../../helper/appimage.dart';
import '../../../helper/searchbar.dart';
import '../../../utils/color_constant.dart';

class SingleCategoryListScreen extends GetView<SingleCategoryListController> {
  const SingleCategoryListScreen({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.white,
      appBar: appBar(context, controller.categoryName.value, () {
        Get.back();
      }),
      body: RefreshIndicator(
        onRefresh: () => controller.allCategoryApiFunction(),
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification.metrics.axis == Axis.vertical) {
              if (scrollNotification is ScrollStartNotification) {
              } else if (scrollNotification is ScrollUpdateNotification) {
              } else if (scrollNotification is ScrollEndNotification) {
                if (scrollNotification.metrics.pixels >=
                    scrollNotification.metrics.maxScrollExtent - 40) {
                  controller.allCategoryPaginationApiFunction();
                  // controller.selectedTabBar.value ==0?
                  // productPaginApiFunction():servicePaginApiFunction();
                }
              }
            }
            return true;
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
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
                          'single',
                          controller.categoryName.value.isEmpty
                              ? ''
                              : controller.category.value,
                          controller.categoryName.value,
                          controller.savedFilterValues
                        ])?.then((value) {
                          if (value != null) {
                            controller.hasOffer.value =
                                value['offer'].toString();
                            controller.category.value =
                                value['category'].toString();
                            controller.subCategory.value =
                                value['subcat'].toString();
                            controller.price.value = value['price'].toString();
                            controller.discount.value =
                                value['discount'].toString();
                            controller.rating.value =
                                value['topRated'].isNotEmpty
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

                            controller.savedFilterValues.value = {
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

                            controller.allCategoryApiFunction();
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
                          color: const Color(0xff767676),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ScreenSize.height(5),
              Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 8, bottom: 6),
                  child: Row(
                    children: [
                      controller.selectedCatList.isNotEmpty
                          ? selectedCategoryWidget()
                          : Container(),
                      controller.savedFilterValues.isNotEmpty &&
                              controller.savedFilterValues
                                  .containsKey('price') &&
                              controller.savedFilterValues['price'] != null &&
                              controller.savedFilterValues['price'].isNotEmpty
                          ? filtersTypesWidget(
                              'Price',
                              controller.savedFilterValues['price'] == 'desc'
                                  ? '(Low to High)'
                                  : '(High to Low)', () {
                              controller.price.value = '';
                              controller.savedFilterValues['price'] = '';
                              controller.allCategoryApiFunction();
                            })
                          : Container(),
                      controller.savedFilterValues.isNotEmpty &&
                              controller.savedFilterValues
                                  .containsKey('discount') &&
                              controller.savedFilterValues['discount'] !=
                                  null &&
                              controller
                                  .savedFilterValues['discount'].isNotEmpty
                          ? filtersTypesWidget(
                              'Discount', '(${controller.discount.value})', () {
                              controller.discount.value = '';
                              controller.savedFilterValues['discount'] = '';
                              controller.allCategoryApiFunction();
                            })
                          : Container(),
                      controller.savedFilterValues.isNotEmpty &&
                              controller.savedFilterValues
                                  .containsKey('topRated') &&
                              controller.savedFilterValues['topRated'] !=
                                  null &&
                              controller
                                  .savedFilterValues['topRated'].isNotEmpty
                          ? filtersTypesWidget('Top Rated', '', () {
                              controller.rating.value = '';
                              controller.savedFilterValues['topRated'] = '';
                              controller.allCategoryApiFunction();
                            })
                          : Container(),
                      controller.savedFilterValues.isNotEmpty &&
                              controller.savedFilterValues
                                  .containsKey('rating') &&
                              controller.savedFilterValues['rating'] != null &&
                              controller.savedFilterValues['rating'].isNotEmpty
                          ? filtersTypesWidget('Rating',
                              '(${controller.savedFilterValues['rating']})',
                              () {
                              controller.rating.value = '';
                              controller.savedFilterValues['rating'] = '';
                              controller.allCategoryApiFunction();
                            })
                          : Container(),
                      controller.savedFilterValues.isNotEmpty &&
                              controller.savedFilterValues
                                  .containsKey('distance') &&
                              controller.savedFilterValues['distance'] !=
                                  null &&
                              controller
                                  .savedFilterValues['distance'].isNotEmpty
                          ? filtersTypesWidget('Distance',
                              '(0-${controller.savedFilterValues['distance']})',
                              () {
                              controller.distance.value = '';
                              controller.savedFilterValues['distance'] = '';
                              controller.allCategoryApiFunction();
                            })
                          : Container(),
                      controller.savedFilterValues.isNotEmpty &&
                              controller.savedFilterValues
                                  .containsKey('arrivals') &&
                              controller.savedFilterValues['arrivals'] !=
                                  null &&
                              controller
                                  .savedFilterValues['arrivals'].isNotEmpty
                          ? filtersTypesWidget('New Arrivals', '', () {
                              controller.newArrivals.value = '';
                              controller.savedFilterValues['arrivals'] = '';
                              controller.allCategoryApiFunction();
                            })
                          : Container(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(),
                  child: Obx(() => controller.isLoading.value
                      ? allExpertShimmer()
                      : controller.allCategoryList.isNotEmpty
                          ? SizedBox(
                              child: RefreshIndicator(
                                onRefresh: () {
                                  allExpertShimmer();
                                  return controller.allCategoryApiFunction();
                                },
                                child: ListView.separated(
                                    separatorBuilder: (context, sp) {
                                      return const SizedBox(
                                        height: 20,
                                      );
                                    },
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 14,
                                        top: 15,
                                        bottom: 30),
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.allCategoryList.length,
                                    physics: const ScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var model =
                                          controller.allCategoryList[index];
                                      return salonWidget(
                                          context, model, 'single', () {
                                        Get.toNamed(
                                            AppRoutes.salonDetailsScreen,
                                            arguments: [
                                              model.userId,
                                              controller.latitude.toString(),
                                              controller.longitude.toString()
                                            ]);
                                      });
                                    }),
                              ),
                            )
                          : noDataFound()),
                ),
              ),
              const SizedBox(
                height: 15,
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
          ),
        ),
      ),
    );
  }

  selectedCategoryWidget() {
    return Row(
      children: List.generate(controller.selectedCatList.length, (i) {
        return filtersTypesWidget(controller.selectedCatList[i]['name'], '',
            () {
          controller.selectedCatList.removeAt(i);
          controller.subCategory.value = controller.selectedCatList
              .expand((category) => category['subCat'])
              .map((subCat) => subCat['id'].toString())
              .join(', ');
          controller.category.value = controller.selectedCatList
              .map((category) => category['id'].toString())
              .join(', ');
          controller.savedFilterValues['category'] = controller.category.value;
          controller.savedFilterValues['subcat'] = controller.subCategory.value;
          controller.savedFilterValues['catList'] = controller.selectedCatList;
          controller.allCategoryApiFunction();
        });
      }),
    );
  }

  filtersTypesWidget(String title, String subTitle, Function() onTap) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: ColorConstant.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorConstant.borderColor)),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            getText(
                title: title,
                size: 15,
                fontFamily: interRegular,
                color: ColorConstant.black3333,
                fontWeight: FontWeight.w500),
            ScreenSize.width(5),
            getText(
                title: subTitle,
                size: 11,
                fontFamily: interRegular,
                color: ColorConstant.black2,
                fontWeight: FontWeight.w400),
            ScreenSize.width(8),
            const Icon(
              Icons.close,
              size: 17,
            )
          ],
        ),
      ),
    );
  }
}

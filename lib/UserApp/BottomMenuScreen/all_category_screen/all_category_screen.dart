import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:senorita/utils/toast.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../helper/appimage.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/size_config.dart';
import '../../../utils/stringConstants.dart';
import '../home_screen/shimmer/all_expert_shimmer.dart';
import 'controller/all_category_controller.dart';

class AllCategoryScreen extends GetView<AllCategoryController> {
  const AllCategoryScreen({key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Obx(()=>
          Column(
      children: [
        SizedBox(
          height: 55,
        ),
        Center(
          child: getText(
              title: "Categories ",
              size: 18,
              fontFamily: interSemiBold,
              color: ColorConstant.blackColor,
              fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
            child:/* Obx(
                  () => controller.isCategoryLoading.value
                  ? allCategoryShimmer()
                  : controller.categoryList.isNotEmpty?SizedBox(
                child: RefreshIndicator(
                  onRefresh: () {
                    allExpertShimmer();
                    return controller.categoryApiFunction();
                  },
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: controller.categoryList.length,
                    itemBuilder: (context, index) {
                      var model = controller.categoryList[index];
                      return GestureDetector(
                          onTap: () {},
                          child:popularCategoryData(context, index, model)
                      );
                    },
                  ),
                ),
              ): Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: getText(
                      title: "",
                      size: 15,
                      fontFamily: interMedium,
                      color: ColorConstant.blackColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )*/
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: controller.categoryList.length,
              itemBuilder: (context, index) {
                var model = controller.categoryList[index];
                return GestureDetector(
                    onTap: () {},
                    child:popularCategoryData(context, index, model)
                );
              },
            ),
          ),
        )
      ],
    ),
    ));
  }

  popularCategoryData(BuildContext context, int index, model) {
    final List<Color> circleColors = [Colors.red, Colors.blue, Colors.green];
    Color randomGenerator() {
      return circleColors[new Random().nextInt(2)];
    }
    return GestureDetector(
      onTap: ()
      {
        Get.toNamed(AppRoutes.singleCategoryListScreen,arguments: [model.categoryId.toString(),model.categoryName.toString()]);
       // showToast(model.categoryId.toString());
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Container(
          decoration: BoxDecoration(
              color: index==0?ColorConstant.card1:
              index==1?ColorConstant.card2:
              index==2?ColorConstant.card3:
              index==3?ColorConstant.card4:ColorConstant.card5,
              borderRadius:BorderRadius.all(Radius.circular(10))
          ),

          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: AnimatedDashedCircle().show(
                      image: NetworkImage(
                        model.imageUrl,
                      ),
                      autoPlay: true,
                      dashSize: 0,
                      contentPadding: 1,
                      //color: ColorConstant.onBoardingBack,
                      duration: Duration(minutes: 1200),
                      borderWidth: 4,
                    ),

                  ),*/
                  /*CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Image.network(model.imageUrl,)

                  ),*/
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                     // borderRadius: BorderRadius.all(Radius.circular(10)),
                      shape: BoxShape.circle,
                     /* border: Border.all(
                        color: Colors.black26,
                      ),*/
                      image: DecorationImage(
                          alignment: Alignment.center,
                          image: NetworkImage(model.imageUrl),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: getText(
                          title: model.categoryName,
                          size: 13,
                          fontFamily: interMedium,
                          color: ColorConstant.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



}

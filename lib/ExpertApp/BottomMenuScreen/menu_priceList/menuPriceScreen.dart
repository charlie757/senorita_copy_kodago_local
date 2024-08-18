import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/menu_priceList/shimmer/price_list.dart';
import 'package:senorita/ScreenRoutes/routes.dart';
import 'package:senorita/helper/appimage.dart';
import 'package:senorita/utils/screensize.dart';
import 'package:senorita/utils/toast.dart';
import '../../../helper/appbar.dart';
import '../../../helper/custombtn_new.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/stringConstants.dart';
import 'controller/menuPriceListcontroller.dart';
import 'model/topic.dart';

class MenuPriceList extends GetWidget<MenuPriceListController> {
  const MenuPriceList({super.key});

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true; // For example, allow back navigation
      },

      child: Scaffold(
        appBar: appBar(context, "Menu & Price List", () {
          Get.back();
        }),
        body:
        Container(
          padding:const EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(context).size.height,
          child: Obx(() => controller.isLoading.value
              ? priceListShimmer():
          controller.getPriceList.isNotEmpty?
          ListView.builder(
              physics: const ScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              // padding: EdgeInsets.zero,
              itemCount: controller.getPriceList.length,
              itemBuilder: (BuildContext context, int index) {
                var priceListModel = controller.getPriceList[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                  child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        // Get.toNamed(AppRoutes.addPriceList);
                      },
                      child: menuUi(context, index)),
                );
              }):Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  AppImages.noDataFound,
                ),
                getText(
                    lineHeight: 1.6,
                    title: "No Data Found",
                    size: 14,
                    fontFamily: interSemiBold,
                    color: ColorConstant.blackColor,
                    fontWeight: FontWeight.w600),
              ],
            ),
          ),),

        ),
        bottomNavigationBar:
        Padding(
          padding: const EdgeInsets.only(left: 0,right: 0,bottom: 0),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: CustomBtnNew(
                  title: "Add More Item",
                  height: 46,
                  width: double.infinity,
                  rectangleBorder: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.transparent,width: 1.3),
                    borderRadius: BorderRadius.circular(0),),
                  color:ColorConstant.onBoardingBack,
                  onTap: () {

                    Get.toNamed(AppRoutes.addPriceList)?.then((value) => controller.getPriceListApiFunction(controller.expertId.value));

                  },textColor: ColorConstant.whiteColor)
          ),
        ),
      ),
    );


  }
  Widget menuUi(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          controller.getPriceList[index]['name'],
          overflow: TextOverflow.ellipsis,
          style:  TextStyle(
            fontSize: 14.0,
            fontFamily: interMedium,
            color: ColorConstant.blackColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        ListView.builder(
            itemCount: controller.getPriceList[index]['data'].length,
            shrinkWrap: true,
            padding:const EdgeInsets.only(top: 5),
            physics: const ScrollPhysics(),
            itemBuilder: (context,i){
          return
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.circle,color: ColorConstant.appColor,size: 10,),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    controller.getPriceList[index]['data'][i]['item_name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontFamily: interMedium,
                      color: ColorConstant.qrViewText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ScreenSize.width(5),
                Container(
                  padding: const EdgeInsets.only(right: 3.0),
                  child: Text(
                    "₹${ controller.getPriceList[index]['data'][i]['price'].toString()}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      letterSpacing: 0.6,
                      fontFamily: interMedium,
                      color: ColorConstant.offerTextBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: ()
                  {
                    controller.removePriceListApiFunction(controller.getPriceList[index]['data'][i]['id'].toString());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: /*Image.asset(
                      height: 20,
                      width: 20,
                      AppImages.removePrice
                    ),*/
                    Icon(Icons.delete_forever,size: 22,color: ColorConstant.redColor,)
                  ),
                ),
              ],
            );
        })
      ],
    );
  }
}

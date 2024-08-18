import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senorita/UserApp/BottomMenuScreen/change_location/change_location_controller.dart';
import 'package:senorita/UserApp/BottomMenuScreen/dashboard_screen/controller/dashboard_controller.dart';
import 'package:senorita/helper/appbar.dart';
import 'package:senorita/helper/appimage.dart';
import 'package:senorita/helper/getText.dart';
import 'package:senorita/helper/searchbar.dart';
import 'package:senorita/utils/color_constant.dart';
import 'package:senorita/utils/screensize.dart';
import 'package:senorita/utils/stringConstants.dart';
import 'package:senorita/utils/utils.dart';
import 'package:senorita/widget/no_data_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLocationScreen extends GetView<ChangeLocationController>{
  const ChangeLocationScreen({super.key});

  @override
  Widget build(BuildContext context){
    final dashboardController = Get.put(DashboardController());
    return GestureDetector(
      onTap: (){
        controller.isShowAddressDropDownItem.value=false;
      },
      child: Scaffold(
        appBar: appBar(context, "Select a location", (){
          controller.isShowAddressDropDownItem.value=false;
          Get.back();
        }),
        body: Padding(padding:const EdgeInsets.only(left: 22,right: 25,top: 7),
        child: Obx(()=>Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchBar(readOnly: false,hintText: 'Search for area, street name...',
                  controller: controller.searchController,
                  onChanged: (val){
                    if(val.isNotEmpty){
                      controller.isShowAddressDropDownItem.value=true;
                      controller.searchAddress(val);
                    }
                    else{
                     controller.suggestionList.clear();
                    }
                  }
                  ),
                  ScreenSize.height(19),
                  currentLocationWidget(dashboardController),
                  ScreenSize.height(33),
                  controller.recentAddress.value.isEmpty?
                      Container():
                  recentAddressWidget(dashboardController)

                ],
              ),
              controller.isShowAddressDropDownItem.value?
              Positioned(
                top: 65,
                  child: showLocationWidget(context,dashboardController)):Container(),
            ],
          ),
        ),
        )
      ),
    );
  }
  currentLocationWidget(DashboardController dashboardController){
    return Obx(()=>InkWell(
        onTap: (){
          dashboardController.address.value = dashboardController.currentAddress.value;
          dashboardController.subLocality.value = dashboardController.currentSubLocality.value;
          dashboardController.currentLat.value = double.parse(controller.lat.value.toString());
          dashboardController.currentLong.value = double.parse(controller.lng.value.toString());
          dashboardController.lat.add(double.parse(controller.lat.value.toString()));
          dashboardController.long.add(double.parse(controller.lng.value.toString()));
             Get.back(result: [
               {"lat":controller.lat.value,"lng":controller.lng.value}
             ]);

          // controller.getCurrentLocation(dashboardController).then((value) {
          //   if(value!=null){
          //    Get.back(result: [
          //      {"lat":controller.lat.value,"lng":controller.lng.value}
          //
          //    ]);
          //   }
          // });
        },
        child: Container(
          // height: 81,
          width: double.infinity,
          decoration: BoxDecoration(
            color:const Color(0xffF5F6FB),
            borderRadius: BorderRadius.circular(6)
          ),
          alignment: Alignment.center,
          padding:const EdgeInsets.only(top: 24,left: 12,bottom: 19,right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AppImages.currentLocationIcon,height: 20,),
              ScreenSize.width(9),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      getText(title: 'Use current location',
                          size: 14, fontFamily: interMedium,
                          color: ColorConstant.appColor, fontWeight: FontWeight.w500),
                    ScreenSize.height(5),
                    Text( dashboardController.currentAddress.value,
                        style:const TextStyle(
                            fontSize: 14, fontFamily: interMedium,
                            color: ColorConstant.qrViewText,
                            fontWeight: FontWeight.w500
                        ),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showLocationWidget(BuildContext context, DashboardController dashboardController){
    print(controller.suggestionList.length);
    return Container(
      width: MediaQuery.of(navigatorKey.currentContext!).size.width,
      constraints:const BoxConstraints(
        minHeight: 100,maxHeight: 400,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            color: ColorConstant.blackColor.withOpacity(.2),
            blurRadius: 10
          )
        ]
      ),
      child:controller.searchController.text.isEmpty?
      Container(
        child: noDataFound(),
      ):
      ListView.separated(
        separatorBuilder: (context,sp){
          return ScreenSize.height(13);
        },
          itemCount: controller.suggestionList.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          padding:const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 20),
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: ()async{
                controller.isShowAddressDropDownItem.value=false;
                controller.searchController.clear();
                dashboardController.address.value = controller.suggestionList[index]['description'];
                dashboardController.subLocality.value =controller.suggestionList[index]['terms'].length>1?
                controller.suggestionList[index]['terms'][1]['value']:controller.suggestionList[index]['terms'][0]['value'];
              SharedPreferences prefs= await SharedPreferences.getInstance();
                prefs.setString('recentAddress', controller.suggestionList[index]['description']);
                prefs.setString('recentSubLocality', dashboardController.subLocality.value);
                controller.getLatLng(controller.suggestionList[index]['description']);
              },
              child: Row(
                children: [
                  // Image.asset(AppImages.location,height: 14,),
                  // ScreenSize.width(15),
                  Text(controller.suggestionList[index]['description']),
                ],
              ),
            );
      }),
    );
  }

  recentAddressWidget(DashboardController dashboardController){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       const getText(title: 'Recent Address',
            size: 18, fontFamily: interMedium, color: ColorConstant.black3333,
            fontWeight: FontWeight.w500),
        ScreenSize.height(19),
        GestureDetector(
          onTap: (){
            controller.isShowAddressDropDownItem.value=false;
            controller.getLatLng(controller.recentAddress.value);
            controller.searchController.clear();
            dashboardController.address.value = controller.recentAddress.value;
            dashboardController.subLocality.value =controller.recentSubLocality.value;
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AppImages.recentLocationIcon,height: 22,),
              ScreenSize.width(13),
              Flexible(
                child: Text( controller.recentAddress.value,
                   style:const TextStyle(
                       fontSize: 14, fontFamily: interMedium
                       , color: ColorConstant.qrViewText, fontWeight: FontWeight.w400
                   ),),
              )
            ],
          ),
        )
      ],
    );
  }
}
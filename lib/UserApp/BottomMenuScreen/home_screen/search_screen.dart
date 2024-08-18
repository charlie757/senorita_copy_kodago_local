import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senorita/helper/appbar.dart';
import 'package:senorita/helper/network_image_helper.dart';
import 'package:senorita/helper/searchbar.dart';
import 'package:senorita/utils/screensize.dart';
import 'package:senorita/widget/no_data_found.dart';

import '../../../ScreenRoutes/routes.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/stringConstants.dart';
import '../../../widget/view_salon_widget.dart';
import 'controller/search_controller.dart';

class SearchScreen extends GetView<SearchSalonController>{


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: appBar(context, 'Search', () {
        Get.back();
      }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() =>Padding(padding:const EdgeInsets.only(left: 15,right: 15,top: 10),child:  searchBar(readOnly: false,
            showPrefix: controller.showPrefix.value,
            clearSearchTap: (){
              controller.showPrefix.value=false;
              controller.searchList.clear();
              controller.isSearch.value=true;
              controller.searchController.clear();
            },
            controller: controller.searchController,
            onChanged: (val){
              if(val.isEmpty){
                controller.isSearch.value = true;
                controller.showPrefix.value=false;
                controller.searchList.clear();
              }
              else{
                controller.allHomeScreenApiFunction(val);
                controller.showPrefix.value=true;
                controller.isSearch.value = false;
              }
            },
          ),)),
          ScreenSize.height(5),
          Expanded(child: Obx(()=>
          controller.isSearch.value?
          noDataFound():
     controller.searchList.isEmpty&&controller.showPrefix.value?
              noDataFound():
              ListView.separated(
                separatorBuilder: (context,sp){
                  return const SizedBox(height: 23,);
                },
                padding:const EdgeInsets.only(left: 15,right: 14,top: 20,bottom: 40),
                shrinkWrap: true,
                itemCount: controller.searchList.length,
                physics:const ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var model = controller.searchList[index];
                  return searchSalonWidget(model);
                }
            ),
          ),
          )
        ],
      ),
    );
  }

  searchSalonWidget(var model){
    return GestureDetector(
      onTap: (){
        Get.toNamed(AppRoutes.salonDetailsScreen, arguments: [
          model['user']['id'].toString(),
          controller.lat.toString(),
          controller.long.toString(),
        ]);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: NetworkImageHelper(
              img: controller.imgBaseUrl.value+
                  model['user']['profile_picture'].toString(),
              width: 75.0,height: 72.0,
            ),
          ),
          ScreenSize.width(16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model['user']!=null?
                  model['user']['name'].toString():"",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: interMedium,
                    color: ColorConstant.blackColorDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ScreenSize.height(4),
                Text(
                      "${model['user']['distance'].toString()} km Away",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontFamily: interMedium,
                    color: ColorConstant.blackLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:senorita/utils/color_constant.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/size_config.dart';

priceListShimmer() {
  return ListView.separated(
    separatorBuilder: (context,sp){
      return const SizedBox(height: 20,);
    },
      itemCount: 10,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      padding: EdgeInsets.only(
          left: SizeConfig.screenHeightConstant * 0.1,
          right: SizeConfig.screenHeightConstant * 0.1,
          bottom: SizeConfig.screenHeightConstant * 2),
      itemBuilder: (context, index) {
        return Container(
           decoration: BoxDecoration(
             color: ColorConstant.white,
             borderRadius: BorderRadius.circular(12),
             boxShadow: [
               BoxShadow(
                 offset:const Offset(0, -2),
                 color: ColorConstant.blackColor.withOpacity(.1),
                 blurRadius: 5
               )
             ]
           ),
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Shimmer.fromColors(
                direction: ShimmerDirection.ltr,
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade50,
                child: Column(
                  children: [
                    Row(
                      children: [

                        SizedBox(
                          width: SizeConfig.screenHeightConstant * 1,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 14,
                              width: 200,
                              color: Colors.grey.shade200,
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeightConstant * 0.2,
                            ),
                            Row(
                              children: [

                              ],
                            ),

                            SizedBox(
                              height: SizeConfig.screenHeightConstant * 1,
                            ),
                            Container(
                              height: 10,
                              width: 150,
                              color: Colors.grey.shade200,
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.grey.shade200,
                            ),

                          ],
                        )
                      ],
                    ),

                  ],
                ),
              ),
            ));
      });
}
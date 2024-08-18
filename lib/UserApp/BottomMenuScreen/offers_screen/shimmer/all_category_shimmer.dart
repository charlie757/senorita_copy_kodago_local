import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/size_config.dart';

allCategoryShimmer() {
  return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      padding: EdgeInsets.only(
          left: SizeConfig.screenHeightConstant * 1,
          right: SizeConfig.screenHeightConstant * 1,
          bottom: SizeConfig.screenHeightConstant * 2),
      itemBuilder: (context, index) {
        return Card(
            elevation: 1,
            shadowColor: const Color(0xff6A6A6A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
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
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey.shade200,
                        ),
                        SizedBox(
                          width: SizeConfig.screenHeightConstant * 1,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 14,
                              width: 80,
                              color: Colors.grey.shade200,
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeightConstant * 1,
                            ),
                            Row(
                              children: [

                              ],
                            ),
                            Container(
                              height: 10,
                              width: 90,
                              color: Colors.grey.shade200,
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeightConstant * 1,
                            ),
                            Container(
                              height: 10,
                              width: 30,
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
                            SizedBox(
                              height: SizeConfig.screenHeightConstant * 1,
                            ),
                            Container(
                              height: 10,
                              width: 60,
                              color: Colors.grey.shade200,
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
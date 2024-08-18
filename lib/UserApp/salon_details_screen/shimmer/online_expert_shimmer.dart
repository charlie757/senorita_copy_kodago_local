import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/color_constant.dart';
import '../../../utils/size_config.dart';

onlineExpertShimmer() {
  return SizedBox(
    height: 500,
    child: ListView.separated(
        separatorBuilder: (context, sp) {
          return const SizedBox(
            width: 10,
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width - 80,
                child: Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: ColorConstant.shimmer,
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: ColorConstant.shimmer,
                          ),
                        ],
                      ),

                      SizedBox(
                          height: 10
                      ),
                      Container(
                        height: 13,
                        width: 130,
                        decoration: BoxDecoration(color:  ColorConstant.shimmer,),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor:  ColorConstant.shimmer,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 8,
                            width: 80,
                            decoration: BoxDecoration(color:  ColorConstant.shimmer,),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 13,
                            width: 120,
                            decoration: BoxDecoration(color:  ColorConstant.shimmer,),
                          ),
                          Spacer(),
                          Container(
                            height: 13,
                            width: 120,
                            decoration: BoxDecoration(color:  ColorConstant.shimmer,),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
  );
}
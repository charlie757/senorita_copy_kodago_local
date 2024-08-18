import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/color_constant.dart';

popularCategoryShimmer() {
  return SizedBox(
    height: double.infinity,
    child: ListView.separated(
        separatorBuilder: (context, sp) {
          return const SizedBox(
            width: 10,
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            shape:const RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(5),)
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(

                width: 55,
                child: Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 50,
                          width: 40,
                          decoration: BoxDecoration(
                              color:  ColorConstant.shimmer,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(5),)
                          ),
                          alignment: Alignment.center,),
                      SizedBox(height: 10,),
                      Container(
                        height: 10,
                        width: 23,
                        decoration: BoxDecoration(color:  ColorConstant.shimmer,),
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
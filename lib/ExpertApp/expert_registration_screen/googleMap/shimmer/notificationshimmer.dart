import 'package:flutter/material.dart';
import 'package:senorita/utils/color_constant.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/size_config.dart';

notificationShimmer(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width/2,
    child: Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Container(
                height: 7,
                width:  MediaQuery.of(context).size.width/2.4,
                decoration: const BoxDecoration(color: ColorConstant.simmer),
              ),
              const SizedBox(height: 8),
              Container(
                height: 7,
                width:  MediaQuery.of(context).size.width/2.2,
                decoration: const BoxDecoration(color: ColorConstant.simmer),
              ),
              const SizedBox(height: 8),
              Container(
                height: 7,
                width:  MediaQuery.of(context).size.width/2,
                decoration: const BoxDecoration(color: ColorConstant.simmer),
              ),

            ],
          )

        ],
      ),
    ),
  );
}
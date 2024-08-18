

import 'package:flutter/material.dart';
import 'package:senorita/utils/color_constant.dart';
Widget bannerIndicator(bool isActive) {
  return SizedBox(
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: isActive ? 5 : 7.0,
      width: isActive ? 20 : 7.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isActive ? ColorConstant.appColor : ColorConstant.blackColor,
      ),
    ),
  );
}
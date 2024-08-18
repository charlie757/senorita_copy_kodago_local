
import 'package:flutter/material.dart';

import '../utils/color_constant.dart';
import '../utils/stringConstants.dart';
import 'appimage.dart';
import 'getText.dart';

AppBar appBar(BuildContext context, String title,  Function() onTap,{isShowLeading =true,List<Widget>? actions}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0.0,
    // leadingWidth: 28,
    leading:isShowLeading? Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Container(
          height: 25,
          width: 25,
          alignment: Alignment.center,
          child: GestureDetector(
              onTap: onTap,
              child: Image.asset(
                AppImages.backIcon,
                height: 25,
                width: 25,
              ))),
    ):Container(),
    title: getText(
        title: title,
        size: 17,
        fontFamily: interSemiBold,
        color: ColorConstant.blackColor,
        fontWeight: FontWeight.w400),
    centerTitle: true,
    actions: actions,
  );
}

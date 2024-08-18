
import 'package:flutter/material.dart';

import '../helper/appimage.dart';
import '../helper/getText.dart';
import '../utils/color_constant.dart';
import '../utils/stringConstants.dart';

Widget noDataFoundImage(BuildContext context){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          width: MediaQuery.of(context).size.width,
          height: 80,
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
  );
}

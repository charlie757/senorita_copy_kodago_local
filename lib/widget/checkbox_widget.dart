
import 'package:flutter/material.dart';

import '../utils/color_constant.dart';

checkBoxWidget(Color color, {double size = 22,Color borderColor =ColorConstant.onBoardingBack }){
  return  Container(
    height: size,width: size,
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: borderColor,width: 1)
    ),
    alignment: Alignment.center,
    child: Icon(Icons.check,size: 16,color: ColorConstant.white,),
  );
}

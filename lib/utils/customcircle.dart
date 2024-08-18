import 'package:flutter/material.dart';
import 'color_constant.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
  dialogContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)
          ),
          alignment: Alignment.center,
          child: Container(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: ColorConstant.onBoardingBack,
              backgroundColor: ColorConstant.white,
            ),
          ),
        )
      ],
    );
  }
}
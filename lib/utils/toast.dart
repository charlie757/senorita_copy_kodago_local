import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import 'color_constant.dart';

/*showSnackBar(String title, message) {
  return Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppTheme.primaryColor,
    forwardAnimationCurve: Curves.easeOutBack,
    colorText: Colors.white,
  );
}*/

showToast(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,

      backgroundColor: ColorConstant.blackColor,
      textColor: Colors.white,
      fontSize: 14.0);
}

showCenterToast(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,

      backgroundColor: ColorConstant.blackColor,
      textColor: Colors.white,
      fontSize: 14.0);
}

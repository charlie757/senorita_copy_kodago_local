import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:senorita/utils/color_constant.dart';


String emailPattern =
    r'^(([^<>()[\]\\.,;:@\"]+(\.[^<>()[\]\\.,;:@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
String gstPattern = '[0-9]{2}[a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9A-Za-z]{1}[Z]{1}[0-9a-zA-Z]{1}';
final whiteSpaceRegex = RegExp(r'\s+');

bool isValidEmail(String? inputString, {bool isRequired = false, }) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {

    isInputStringValid = true;

  }

  if ( inputString != null && inputString.isNotEmpty ) {

    const pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString) ;

  }
  return isInputStringValid;
}

bool kodagoCard(String? inputString, {bool isRequired = false, }) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {

    isInputStringValid = true;

  }

  if ( inputString != null && inputString.isNotEmpty ) {

    const pattern = r'https://card.kodago.com/';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString) ;

  }
  return isInputStringValid;
}


bool isValidPhone(String? inputString, {bool isRequired = false, }) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {

    isInputStringValid = true;

  }

  if (inputString != null &&  inputString.isNotEmpty) {

    if (inputString.length > 16 || inputString.length < 6) return false;

    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString) ;

  }

  return isInputStringValid; } /// Checks if string consist only numeric.

/// at least a upper case letter
///  at least a lower case letter
///  at least a digit
///  at least a special character [@#$%^&+=]
///  length of at least 4
/// no white space allowed
bool isValidPassword(String? inputString, {bool isRequired = false, }) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {

    isInputStringValid = true;

  }

  if ( inputString != null && inputString.isNotEmpty ) {

    const pattern = r'^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString) ;

  }

  return isInputStringValid; }




internetSnackbar() {
  ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
      shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(3)),
      //  margin: EdgeInsets.only(left: 20,right: 20,bottom: bottom),
      backgroundColor: Colors.red,
      content: Text('No internet connectivity')));
}

 successSnackBar(
    String title,
    BuildContext context,
    ) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      shape: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstant.appColor.withOpacity(.9)),
          borderRadius: BorderRadius.circular(3)),
      // margin: EdgeInsets.only(left: 20, right: 20,),
      backgroundColor: ColorConstant.appColor.withOpacity(.9),
      content: Text(
        title,
        style:const TextStyle(color: ColorConstant.whiteColor),
      )));
}
errorSnackBar(
    String title,
    context,
    ) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      shape: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstant.redColor.withOpacity(.8)),
          borderRadius: BorderRadius.circular(3)),
      //  margin: EdgeInsets.only(left: 20,right: 20,bottom: bottom),
      backgroundColor: ColorConstant.redColor.withOpacity(.8),
      content: Text(
        title,
        style:const TextStyle(color: ColorConstant.whiteColor),
      )));
}


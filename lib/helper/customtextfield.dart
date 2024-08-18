
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/color_constant.dart';
import '../utils/stringConstants.dart';

// ignore: must_be_immutable
class CustomTextfield extends StatefulWidget {
  String? hintText;
  final TextEditingController controller;
  Widget? prefix;
  Widget? suffix;
  Widget? textStyle;
  final validator;
  List<TextInputFormatter>? inputFormatters;
  bool? isObscureText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;


  AutovalidateMode? auto;
  final isReadOnly;
  CustomTextfield(
      {key,
      required this.hintText, this.validator, required this.controller,
      this.textInputType = TextInputType.text, this.inputFormatters,
        this.textInputAction=TextInputAction.next,
      this.prefix, this.suffix, this.isObscureText = false, this.isReadOnly = false,this.auto,});
  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        readOnly: widget.isReadOnly,
        obscureText: widget.isObscureText!,
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,

        keyboardType: widget.textInputType,
        textInputAction:widget.textInputAction,
        cursorColor: ColorConstant.onBoardingBack,
        autovalidateMode: widget.auto,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,

        /*IconButton(
          icon: Icon(
            controller.passwordVisible.value
                ? Icons.visibility
                : Icons.visibility_off,
            color: ColorConstant.buttonBorder,
          ),
          onPressed: () {
            controller.passwordVisible.value =
            !controller.passwordVisible.value;
          },
        ),*/
        decoration: InputDecoration(
          isDense: true,
          fillColor: ColorConstant.whiteColor,
          filled: true,
          hintText: widget.hintText,
          prefixIcon: widget.prefix,
          suffixIcon:widget.suffix,
          hintStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: celiaRegular,
              color: ColorConstant.black2),
         border: InputBorder.none,
         /* border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorConstant.black2,
              ),
              borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(8)),
          errorBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.redColor)),
          focusedErrorBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.redColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorConstant.naviBlueColor,
              ),
              borderRadius: BorderRadius.circular(8)),*/
        ),
      ),
    );
  }
}

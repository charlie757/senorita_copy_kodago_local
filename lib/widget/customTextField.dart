
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/color_constant.dart';
import '../utils/stringConstants.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  String? hintText;
  final TextEditingController controller;
  Widget? prefix;
  Widget? suffix;
  Widget? textStyle;
  String? labelText;
  String? value;
  final validator;
  List<TextInputFormatter>? inputFormatters;
  bool? isObscureText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  AutovalidateMode? auto;
  final isReadOnly;
  CustomTextField(
      {key,
        required this.hintText,required this.labelText, this.validator, required this.controller,
        this.textInputType = TextInputType.text, this.inputFormatters,
        this.textInputAction=TextInputAction.next,
        this.prefix, this.suffix, this.isObscureText = false, this.isReadOnly = false,this.auto,});
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode myFocusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        focusNode: myFocusNode,
        readOnly: widget.isReadOnly,
        obscureText: widget.isObscureText!,
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        textInputAction:widget.textInputAction,
        autovalidateMode: widget.auto,
        validator: widget.validator,
        minLines: 1, //Normal textInputField will be displayed
        maxLines: 100,
        cursorColor: ColorConstant.onBoardingBack,
        decoration: InputDecoration(

          isDense: true,
          fillColor: ColorConstant.white,
          filled: true,
          hintText: widget.hintText,
          prefixIcon: widget.prefix,
          labelText: widget.labelText,
          labelStyle: TextStyle(
               fontSize: 13,
              fontFamily: interRegular,
              color: myFocusNode.hasFocus ? ColorConstant.greyColor : ColorConstant.greyColor
          ),
          suffixIcon:widget.suffix,
          hintStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: interMedium,
              color: ColorConstant.black2),
          /*border: InputBorder.none,*/

          border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorConstant.addMoney,
              ),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color:ColorConstant.addMoney,
              ),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstant.onBoardingBack,)),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:ColorConstant.addMoney,)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color:ColorConstant.addMoney,
              ),
              borderRadius: BorderRadius.circular(10)),
        ),
        style: TextStyle(
            fontSize: 14.0,
          color: ColorConstant.blackColor,
          fontWeight: FontWeight.w400
        ),
      ),
    );
  }
}

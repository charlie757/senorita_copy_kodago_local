
import 'package:flutter/material.dart';

import '../utils/color_constant.dart';
import '../utils/stringConstants.dart';
import 'getText.dart';

class CustomBtn extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final Color color;
  final bool isLoading;

  final Function() onTap;
  const CustomBtn(
      {key,
      required this.title,
      required this.height,
      required this.width,
      required this.onTap,
      required this.color,
      this.isLoading = false});

  @override
  State<CustomBtn> createState() => _CustomBtnState();
}

class _CustomBtnState extends State<CustomBtn> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(

          backgroundColor: widget.isLoading ? ColorConstant.c3Color : widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),)),
      onPressed: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        height: widget.height,
        width: widget.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.isLoading
                ? Container(
                    height: 24,
                    width: 24,
                    margin: const EdgeInsets.only(right: 10),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Container(),
            getText(
                title: widget.title,
                size: 15,
                letterSpacing: 0.9,
                fontFamily: interSemiBold,
                color: ColorConstant.white,
                fontWeight: FontWeight.w600),
          ],
        ),
      ),
    );
  }
}

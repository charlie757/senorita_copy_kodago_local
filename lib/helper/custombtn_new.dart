
import 'package:flutter/material.dart';

import '../utils/color_constant.dart';
import '../utils/stringConstants.dart';
import 'getText.dart';

class CustomBtnNew extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final Color color;
  final Color textColor;
  final RoundedRectangleBorder rectangleBorder;
  final bool isLoading;

  final Function() onTap;
  const CustomBtnNew(
      {key,
      required this.title,
      required this.height,
      required this.width,
      required this.onTap,
      required this.color, required this.textColor,
        required this.rectangleBorder,
      this.isLoading = false});

  @override
  State<CustomBtnNew> createState() => _CustomBtnNewState();
}

class _CustomBtnNewState extends State<CustomBtnNew> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      style: ElevatedButton.styleFrom(elevation: 0,
          backgroundColor: widget.isLoading ? ColorConstant.c3Color : widget.color,
          shape:  widget.rectangleBorder),
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
                size: 14,
                fontFamily: interSemiBold,
                color: widget.textColor,
                fontWeight: FontWeight.w600),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

import '../utils/color_constant.dart';
import '../utils/stringConstants.dart';
import 'getText.dart';

class CombineColorBtn extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final Color color;
  final Function() onTap;
  const CombineColorBtn({
    key,
    required this.title,
    required this.height,
    required this.width,
    required this.onTap,
    required this.color,
  });

  @override
  State<CombineColorBtn> createState() => _CombineColorBtnState();
}

class _CombineColorBtnState extends State<CombineColorBtn> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          // elevation: 0,
          backgroundColor: widget.color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      onPressed: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        height: widget.height,
        width: widget.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getText(
                title: widget.title,
                size: 14,
                fontFamily: celiaBold,
                color: ColorConstant.white,
                fontWeight: FontWeight.w700),
          ],
        ),
      ),
    );
  }
}

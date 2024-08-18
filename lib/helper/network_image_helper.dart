// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:senorita/utils/color_constant.dart';

class NetworkImageHelper extends StatelessWidget {
  final img;
  final width;
  final height;
  final isAnotherColorOfLodingIndicator;
  const NetworkImageHelper(
      {super.key,
        this.img,
        this.width,
        this.height,
        this.isAnotherColorOfLodingIndicator = false});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: img,
      width: width,
      height: height,
      fit: BoxFit.cover,
        errorWidget: (context, url, error) =>
            Image.network(
              "https://raysensenbach.com/wp-content/uploads/2013/04/default.jpg",
              height: 200,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),

      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
              color: isAnotherColorOfLodingIndicator
                  ? ColorConstant.redColor
                  : ColorConstant.appColor,
              strokeWidth: 2,
              value: downloadProgress.progress)),
      // errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}

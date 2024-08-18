import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:senorita/helper/appimage.dart';

ratingWidget(
    {required double size,
      required double initalRating,
      required bool isGesture,
      required ValueChanged<double> onRatingUpdate}) {
  return RatingBar(
      initialRating: initalRating,
      minRating: 1,
      ignoreGestures: isGesture,
      glow: false,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemSize: size,
      itemPadding:const EdgeInsets.only(right:6),
      unratedColor: const Color(0xffDADADB),
      ratingWidget: RatingWidget(full: Image.asset(AppImages.ratedStarIcon),
          half: Image.asset(AppImages.ratedStarIcon), empty: Image.asset(AppImages.unRatedStarIcon)),
      updateOnDrag: true,
      onRatingUpdate: onRatingUpdate);
}

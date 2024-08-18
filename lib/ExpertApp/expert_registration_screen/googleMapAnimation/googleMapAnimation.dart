import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:senorita/ExpertApp/expert_registration_screen/googleMap/shimmer/notificationshimmer.dart';

import 'package:senorita/helper/appimage.dart';
import 'package:senorita/utils/color_constant.dart';
import 'package:senorita/utils/toast.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import '../../../helper/appbar.dart';
import '../../../helper/custombtn.dart';
import '../../../helper/getText.dart';
import '../../../utils/size_config.dart';
import '../../../utils/stringConstants.dart';
import 'controller/googleMapAnimationController.dart';

class GoogleMapAnimation extends GetView<MapAnimationController> {
  const GoogleMapAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    //controller.getUserLocation();
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
    //     .copyWith(statusBarBrightness: Brightness.light));
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage(AppImages.mapAnimationBack),
              fit: BoxFit.fill,
            )
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
          Center(
          child: RippleAnimation(
              color:ColorConstant.animation,
          delay: const Duration(milliseconds: 300),
          repeat: true,
          minRadius: 85,
          ripplesCount: 3,
          duration: const Duration(milliseconds: 6 * 300),
          child:  Image.asset(
            width: 45,
            height:45,
            color:ColorConstant.onBoardingBack,
            AppImages.markerAnimation,),
        ),
      ),
              Center(
                child:  Padding(
                  padding: const EdgeInsets.only(top: 160),
                  child: getText(
                      title: "Fetching Your Location...",
                      textAlign: TextAlign.start,
                      size: 18,
                      fontFamily: interSemiBold,
                      color: ColorConstant.blackColor,
                      fontWeight: FontWeight.w600),
                ),
              )




            ],
          ),
        ),
      ),
    );

  }

}

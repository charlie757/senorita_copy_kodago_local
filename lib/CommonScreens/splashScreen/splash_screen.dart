import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/appimage.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Image.asset(
          // fit: BoxFit.cover,
          AppImages.splashCenter,
          width: double.infinity,
          height: double.infinity,
        ));
  }
}

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:senorita/utils/toast.dart';

import '../../../../ScreenRoutes/routes.dart';

class MapAnimationController extends GetxController{
  final activegps = true.obs;
  final subLocality = "".obs;
  final locality = "".obs;
  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 10), () {
      Get.toNamed(AppRoutes.googleMap);
      /*Get.toNamed(AppRoutes.googleMap,arguments: [
        null,null,null]);*/
    });

    super.onInit();
  }
 /* void getUserLocation() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      activegps.value = false;
    } else {
      activegps.value = true;
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemark =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      subLocality.value = placemark[0].subLocality.toString();
      locality.value = placemark[0].street.toString() +
          "," +
          placemark[0].subLocality.toString() +
          "," +
          placemark[0].locality.toString() +
          "," +
          placemark[0].country.toString();

      *//*position.latitude!=""?*//*
     *//* Get.toNamed(AppRoutes.googleMap,arguments: ["editProfile"])
          :SizedBox();*//*
      Get.toNamed(AppRoutes.googleMap,arguments: [null,null,null]);
    }
  }*/

}

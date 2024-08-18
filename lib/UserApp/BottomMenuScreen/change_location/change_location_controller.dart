import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart'as http;
import 'package:senorita/UserApp/BottomMenuScreen/dashboard_screen/controller/dashboard_controller.dart';
import 'package:senorita/utils/showcircledialogbox.dart';
import 'package:senorita/utils/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLocationController extends GetxController{

  final isShowAddressDropDownItem = false.obs;
  final searchController = TextEditingController();
  final dashboardController = Get.put(DashboardController());

  final recentAddress = ''.obs;
  final recentSubLocality = ''.obs;
final lat = ''.obs;
  final lng = ''.obs;
  @override
  void onInit() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    recentAddress.value= prefs.getString('recentAddress')??'';
    recentSubLocality.value = prefs.getString('recentSubLocality')??'';
    getCurrentLocation(dashboardController);
    // TODO: implement onInit
    super.onInit();
  }

  final suggestionList = [].obs;
  Future<void> searchAddress(String input) async {
     String apiKey = 'AIzaSyBSc7xDt-OoXTcYb3IjIcsAmns-RhuofL4'; // Replace with your API key
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    log(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // setState(() {
        suggestionList.value = data['predictions'];
            // .map<String>((prediction) => prediction['description'])
            // .toList();
      // });

    } else {
      throw Exception('Failed to load suggestions');
    }
  }



 Future getCurrentLocation(DashboardController dashboardController)async {
    // showCircleProgressDialog(navigatorKey.currentContext!);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!(await Geolocator.isLocationServiceEnabled())) {
    } else {
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
      prefs.setString('lat',position.latitude.toString());
      prefs.setString('long',position.longitude.toString());
      lat.value = position.latitude.toString();
      lng.value =position.longitude.toString();
      dashboardController.currentSubLocality.value =
          placemark[0].subLocality.toString();
      dashboardController.currentAddress.value =
      "${placemark[0].street.toString()}${placemark[0].thoroughfare
          .toString()
          .isNotEmpty
          ? ", ${placemark[0].thoroughfare.toString()}"
          : ''}${placemark[0].subLocality
          .toString()
          .isNotEmpty
          ? ", ${placemark[0].subLocality.toString()}"
          : ""}${placemark[0].locality
          .toString()
          .isNotEmpty
          ? ", ${placemark[0].locality.toString()}"
          : ""}${placemark[0].administrativeArea
          .toString()
          .isNotEmpty
          ? ", ${placemark[0].administrativeArea.toString()}"
          : ""}${placemark[0].country
          .toString()
          .isNotEmpty ? ", ${placemark[0].country.toString()}" : ''}";
      dashboardController.city.value = placemark[0].locality.toString();
      dashboardController.state.value =
          placemark[0].administrativeArea.toString();
      print(lng.value);
      // Get.back();
      return position.latitude;
    }
  }
  Future<void> getLatLng(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      showCircleProgressDialog(navigatorKey.currentContext!);
      List<Location> locations = await locationFromAddress(address);
      Get.back();
      if (locations.isNotEmpty) {
        final location = locations.first;
        prefs.setString('lat',location.latitude.toString());
        prefs.setString('long',location.longitude.toString());

        Get.back(result: [
          {"lat":location.latitude.toString(),"lng":location.longitude.toString()}
        ]);
        print(location);
        lat.value = location.latitude.toString();
        lng.value = location.longitude.toString();
      } else {
        Get.back();
      }
    } catch (e) {
    }
  }
}
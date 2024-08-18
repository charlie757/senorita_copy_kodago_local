import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:senorita/ScreenRoutes/routes.dart';
import 'package:senorita/utils/toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../placeapi.dart';



class MapController extends GetxController {

  LatLng initialposition = LatLng(-0, -0);
  LatLng changeInitialposition = LatLng(-0, -0);
  List<double> lat = []; // Creating an empty list for latitude values
  List<double> long = []; // Creating an empty list for longitude values
  late GoogleMapController googleMapController;

  GoogleMapController get mapController => googleMapController;
  final activegps = true.obs;

  LatLng get initialPos => initialposition;

  final markerList = [].obs;
  final markerIdList = [].obs;

  final currentLat = 0.0.obs;
  final currentLong = 0.0.obs;

  final subLocality = "".obs;
  final address = "".obs;
  final city = "".obs;

  final state = "".obs;
  late LatLng draggedLatlng;
  String type = "";
  String screenName = "";

 // List<dynamic> predictionList = [];
  List<Prediction> predictionList = [];
  final TextEditingController mapControllerText = TextEditingController();

  var uuid =Uuid();
  String _sessionToken = '122344';




  @override
   onInit() async {


   // getUserLocation();

    mapControllerText.addListener(() {
      onChange();
    });


    super.onInit();
  }
  void onChange()
  {
    if(_sessionToken ==null)
      {
        _sessionToken=uuid.v4();
      }

  }

  void getUserLocation() async {
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
      EasyLoading.show(status:"Loading....");
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      initialposition = LatLng(position.latitude, position.longitude);
      print(
          "the latitude is: ${position.longitude} and th longitude is: ${position.longitude} ");
      lat.add(position.longitude);
      long.add(position.longitude);

      currentLat.value = position.latitude;
      currentLong.value = position.longitude;



      initialposition = LatLng(currentLat.value,currentLong.value);


      subLocality.value = placemark[0].subLocality.toString();
      address.value =
      placemark[0].street.toString()+","+
      placemark[0].thoroughfare.toString()+","+
      placemark[0].subLocality.toString()+","+
      placemark[0].locality.toString()+","+
      placemark[0].administrativeArea.toString()+","+
      placemark[0].country.toString();
      city.value=placemark[0].locality.toString();
      state.value=placemark[0].administrativeArea.toString();
      googleMapController.moveCamera(CameraUpdate.newLatLng(initialposition));
      EasyLoading.dismiss();
    }
  }

  void onCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  void onCameraMove(position) async {
    position = CameraPosition(target: position.target, zoom: 18.0);
  //  draggedLatlng =  position.target;
    initialposition = position.target;
    List<Placemark> placemarks = await placemarkFromCoordinates(position.target.latitude,position.target.longitude);
    Placemark addressNew = placemarks[0]; // get only first and closest address
    address.value = ""
        "${addressNew.street},"
        "${addressNew.thoroughfare},"
        "${addressNew.subLocality},"
        "${addressNew.locality}, "
        "${addressNew.administrativeArea},"
        "${addressNew.country}";

  }

  void getMoveCamera(lat,long) async {
    changeInitialposition = LatLng(lat, long);
    /*draggedLatlng=changeInitialposition;

    currentLat.value=draggedLatlng.latitude;
    currentLong.value=draggedLatlng.longitude;*/
    googleMapController.moveCamera(CameraUpdate.newLatLng(changeInitialposition));
  }
}

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
import 'package:senorita/utils/toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../../../ScreenRoutes/routes.dart';
import '../placeapi.dart';



class SearchEditLocationController extends GetxController {

  LatLng initialposition = LatLng(-0, -0);
  List<double> lat = []; // Creating an empty list for latitude values
  List<double> long = []; // Creating an empty list for longitude values
  late GoogleMapController _mapController;

  GoogleMapController get mapController => _mapController;
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

  String screenName = "";

  final description = "".obs;

  var latDouble=0.0;
  var lngDouble=0.0;

 // List<dynamic> predictionList = [];
  List<Prediction> predictionList = [];
  final TextEditingController mapControllerText = TextEditingController();

  var uuid =Uuid();
  String _sessionToken = '122344';


  @override
  void onInit() {



    mapControllerText.addListener(() {
      onChange();
    });
    //getUserLocation();

    //getSuggestion(mapControllerText.text);

    super.onInit();
  }
  void onChange()
  {
    // ignore: unnecessary_null_comparison
    if(_sessionToken ==null)
      {
        _sessionToken=uuid.v4();
      }

  }




  void getUserLocation() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      activegps.value = false;
    }
    else {
      EasyLoading.show(status: "Loading");
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
      initialposition = LatLng(position.latitude, position.longitude);
      print(
          "the latitude is: ${position.longitude} and th longitude is: ${position.longitude} ");
      lat.add(position.longitude);
      long.add(position.longitude);

      currentLat.value = position.latitude;
      currentLong.value = position.longitude;
      showToast(currentLat.value.toString());

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
      EasyLoading.dismiss();
      Get.toNamed(AppRoutes.editMap,arguments: [
        currentLat.value,
        currentLong.value,
        address.value.toString()]);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('lat', currentLat.value.toString());
      prefs.setString('Long', currentLong.value.toString());
      prefs.setString('address', address.value.toString());

      // _mapController.moveCamera(CameraUpdate.newLatLng(initialposition));
    }
  }

  void onCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void onCameraMove(position) async {
    position = CameraPosition(target: position.target, zoom: 18.0);
    initialposition = position.target;
  }

  void getMoveCamera() async {
    List<Placemark> placemark = await placemarkFromCoordinates(
        initialposition.latitude, initialposition.longitude,
        localeIdentifier: "en_US");
  }

  ///Search Map Location
  Future<List<Prediction>> searchLocation(BuildContext context, String text) async {
    if (text.isNotEmpty) {
      http.Response response = await getLocationData(text,context);
      var data = jsonDecode(response.body.toString());
      print("my status is " + data["status"]);
      if (data['status'] == 'OK') {
        predictionList = [];
        data['predictions'].forEach((prediction) => predictionList.add(Prediction.fromJson(prediction)));



      } else {

        // ApiChecker.checkApi(response);
      }
    }
    else
      {
        predictionList=[];
      }
    return predictionList;
  }
  Future<Map<String, double>> getLatLngFromPlaceId(String placeId) async {
    final apiKey = 'AIzaSyAopcumfPIKkHn4Ym1z2AeU0RDEAAY0ZXo'; // Replace with your Google Maps API Key
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?place_id=$placeId&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final results = json['results'] as List<dynamic>;
      if (results.isNotEmpty) {
        final location = results[0]['geometry']['location'];
        final lat = location['lat'] as double;
        final lng = location['lng'] as double;
        currentLat.value=lat;
        currentLong.value=lng;
        Get.toNamed(AppRoutes.editMap,arguments: [
          currentLat.value,
          currentLong.value,
          address.value.toString()]);

        return {'latitude': lat, 'longitude': lng};
      } else {
        throw Exception('No results found');
      }
    } else {
      throw Exception('Failed to fetch data from Google Maps API');
    }
  }

  /*getSuggestion(String text) async {
    String kPLACES_API_KEY = "AIzaSyAopcumfPIKkHn4Ym1z2AeU0RDEAAY0ZXo";
    String baseURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request= "$baseURL?input=$text&key=$kPLACES_API_KEY";

    var response=await http.get(Uri.parse(request));
    if(response.statusCode == 200)
    {
      predictionList =jsonDecode(response.body.toString())["predictions"];
      // predictionList = jsonEncode(response.body.toString()) as List;
    }else
    {
      throw Exception('Failed to load data');
    }

  }*/
}

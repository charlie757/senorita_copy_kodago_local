
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:senorita/ExpertApp/expert_registration_screen/googleMap/shimmer/notificationshimmer.dart';

import 'package:senorita/helper/appimage.dart';
import 'package:senorita/utils/color_constant.dart';
import 'package:senorita/utils/toast.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../helper/appbar.dart';
import '../../../helper/custombtn.dart';
import '../../../helper/getText.dart';
import '../../../utils/size_config.dart';
import '../../../utils/stringConstants.dart';
import '../../../widget/customTextField.dart';
import '../controller/expert_registration_controller.dart';
import 'controller/googleMapController.dart';

class GoogleMapScreen extends GetView<MapController> {
  @override
  Widget build(BuildContext context) {
   /* final data = Get.arguments;

    if (data[0] != null || data[1] != null || data[2] != null) {
      controller.address.value = data[2] ?? "";
      //controller.getMoveCamera(data[0],data[1]);


      controller.initialposition = LatLng(data[0],data[1]);

      controller.currentLat.value=data[0];
      controller.currentLong.value=data[1];




    } else {

      controller.getUserLocation();
    }*/
    controller.getUserLocation();

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
    //     .copyWith(statusBarBrightness: Brightness.light));
    return WillPopScope(
      onWillPop: () async {
        controller.screenName == "EditProfile"
            ? Get.offAllNamed(AppRoutes.expertEditProfileScreen)
            : Get.toNamed(AppRoutes.expertRegistrationScreen);
        /* controller.type=="registrationExpert"?
        Get.toNamed(AppRoutes.expertRegistrationScreen):Get.toNamed(AppRoutes.expertRegistrationScreen);*/

        return false;
      },
      child: Scaffold(
        appBar: appBar(context, () {
          controller.screenName == "EditProfile"
              ? Get.offAllNamed(AppRoutes.expertEditProfileScreen)
              : Get.toNamed(AppRoutes.expertRegistrationScreen);
        }),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _getMap(),
              _getCustomPin(),
          Positioned(
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: ()
                    {
                      controller.getUserLocation();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 40,right: 15),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(100)),
                                border: Border.all(
                                    color: ColorConstant.white)),
                          height: 50,
                          width: 50,
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Center(child: Icon(Icons.my_location,color: Colors.indigoAccent,)),
                          )
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Container(
                      height: 125,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      AppImages.cardIcon,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width / 1.5,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Obx(() => controller.address.value != ""
                                          ? Obx(
                                            () =>
                                            getText(
                                                title: controller
                                                    .address.value,
                                                size: 14,
                                                textOverflow:
                                                TextOverflow.ellipsis,
                                                fontFamily: interRegular,
                                                color: ColorConstant
                                                    .redeemTextDark,
                                                fontWeight:
                                                FontWeight.w500),
                                      )
                                          : notificationShimmer(context)),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      /* Obx(
                                            () => getText(
                                                title: controller.address.value,
                                                size: 14,
                                                textOverflow: TextOverflow.ellipsis,
                                                fontFamily: interRegular,
                                                color: ColorConstant.redeemTextDark,
                                                fontWeight: FontWeight.w500),
                                          ),*/
                                    ],
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {

                                    Get.toNamed(AppRoutes.searchLocationSearch,/*arguments: [
                                      controller.screenName.toString(),]*/);
                                    // controller.getSuggestion(controller.mapControllerText.text);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3)),
                                        border: Border.all(
                                            color: ColorConstant.checkBox)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: getText(
                                          title: "Change",
                                          size: 12,
                                          fontFamily: interMedium,
                                          color: ColorConstant.blackColorLight,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CustomBtn(
                                title: "Confirm Address",
                                height: 45,
                                width: double.infinity,
                                color: ColorConstant.onBoardingBack,
                                onTap: () {

                                  /*var dataToSend = {
                                    'address': controller.address.toString(),
                                    'city': controller.city.value.toString(),
                                    'state': controller.state.value.toString(),
                                    'currentLat':  controller.currentLat.value.toString(),
                                    'currentLong':  controller.currentLong.value.toString(),
                                  };
                                  Get.offAllNamed(
                                    AppRoutes.expertRegistrationScreen,
                                    parameters:  dataToSend,
                                  );*/
                                  Get.toNamed(AppRoutes.expertRegistrationScreen,arguments: [
                                    controller.currentLat.value,
                                    controller.currentLong.value,
                                    controller.address.toString(),
                                  ]);

                                  //   Get.toNamed(context, route, replace: true);
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ))

            ],
          ),
        ),
      ),
    );

  }

  Widget _getMap() {
    return  /*Obx(()=>
      GoogleMap(
        onTap: (LatLng latLng) {

        },
        zoomControlsEnabled: true,
        mapType: MapType.normal,
        markers:Set.from(controller.markerList.value),
        compassEnabled: false,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        initialCameraPosition: CameraPosition(target: controller.initialPos, zoom: 16.0),
        onMapCreated: controller.onCreated,
        onCameraIdle: () {
          getAddress(controller.draggedLatlng);
          controller.currentLat.value=controller.draggedLatlng.latitude;
          controller.currentLong.value=controller.draggedLatlng.longitude;
        },
        onCameraMove: (cameraPosition) {
          controller.draggedLatlng = cameraPosition.target;
        },
      ),
    );*/
      controller.activegps.value == false
          ? Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Center(               child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 250,
              width: 250,
              child: Image.asset('assets/images/nogps.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'You must activate GPS to get your location',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                controller.getUserLocation();
              },
              child: Text('try again'),
            )
          ],
        ),
        ),
      )
          : SafeArea(
        child:
        GoogleMap(
        onTap: (LatLng latLng) {

    },
    zoomControlsEnabled: true,
    mapType: MapType.normal,
    markers:Set.from(controller.markerList.value),
    compassEnabled: false,
    myLocationEnabled: false,
    myLocationButtonEnabled: false,
    initialCameraPosition: CameraPosition(target: controller.initialPos, zoom: 16.0),
    onMapCreated: controller.onCreated,
    onCameraMove: controller.onCameraMove,
    /* onCameraMove: (cameraPosition) {
              controller.draggedLatlng = cameraPosition.target;
            },*/
    /*onCameraIdle: () {
              getAddress(controller.draggedLatlng);
              controller.currentLat.value=controller.draggedLatlng.latitude;
              controller.currentLong.value=controller.draggedLatlng.longitude;
            },
            onCameraMove: (cameraPosition) {
              controller.draggedLatlng = cameraPosition.target;
            },*/
    ));
  }
  Widget _getCustomPin() {
    return   Center(
      child: Container(
        width: 150,
        child:  Icon(
          size: 40,
          color: ColorConstant.onBoardingBack,
            Icons.location_on)
      ),
    );
  }


  AppBar appBar(BuildContext context, Function() onTap) {
    return AppBar(
      backgroundColor: ColorConstant.white,
      elevation: 0,
      leadingWidth: 30,
      automaticallyImplyLeading: false,
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 18,
                    width: 20,
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppImages.appBar,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                getText(
                    title: "Select Location",
                    size: 16,
                    fontFamily: interRegular,
                    color: ColorConstant.blackColor,
                    fontWeight: FontWeight.w500),
                Spacer(),
              ],
            ),
          ),
        ),
      ],
      centerTitle: true,
    );
  }

  //get address from dragged pin
  Future getAddress(LatLng position) async {
    //this will list down all address around the position
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0]; // get only first and closest address

   /* address.value =
        placemark[0].street.toString()+","+
            placemark[0].thoroughfare.toString()+","+
            placemark[0].subLocality.toString()+","+
            placemark[0].locality.toString()+","+
            placemark[0].administrativeArea.toString()+","+
            placemark[0].country.toString();*/

    String addresStr = "${address.street} ${address.thoroughfare}, ${address.subLocality},${address.locality}, ${address.administrativeArea}, ${address.country}";

    controller.address.value=addresStr;
  }

}

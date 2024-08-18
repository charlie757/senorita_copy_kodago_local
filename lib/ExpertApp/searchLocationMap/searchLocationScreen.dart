import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
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
import '../expert_registration_screen/googleMap/controller/googleMapController.dart';
import 'controller/searchLocationController.dart';

class SearchLocationScreen extends GetView<SearchLocationController> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
    //     .copyWith(statusBarBrightness: Brightness.light));
    return WillPopScope(
      onWillPop: () async {
        Get.back();

        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context, () {
          Get.back();
        }),
        body: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width - 0,
              color: ColorConstant.addPriceListText,
              height: 1,
            ),
            SizedBox(
              height: 50,
              child: Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                            padding: const EdgeInsets.only(
                                left: 5, right: 4, top: 5),
                            child: Icon(
                              Icons.location_on_outlined,
                              color: ColorConstant.onBoardingBack,
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.7,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {},
                              child: TypeAheadField(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    controller: controller.mapControllerText,
                                    textInputAction: TextInputAction.search,
                                    //autofocus: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    keyboardType: TextInputType.streetAddress,
                                    decoration: InputDecoration(
                                      hintText: 'Search location...',
                                      border: InputBorder.none,
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            fontSize: 15,
                                            color:
                                                Theme.of(context).disabledColor,
                                            overflow: TextOverflow.fade,
                                          ),
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.color,
                                          fontSize: 15,
                                        ),
                                  ),
                                  suggestionsCallback: (pattern) async {
                                    return await Get.find<
                                            SearchLocationController>()
                                        .searchLocation(context, pattern);
                                  },
                                  itemBuilder:
                                      (context, Prediction suggestion) {
                                    return Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Container(
                                        height: 50,
                                        child: Row(children: [
                                          Icon(Icons.location_on),
                                          Expanded(
                                            child: Container(
                                              height: 30,
                                              child: Text(
                                                  suggestion.description!,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium
                                                      ?.copyWith(
                                                        color: Colors.black87,
                                                        fontSize: 20,
                                                      )),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    );
                                  },
                                  onSuggestionSelected:
                                      (Prediction suggestion) async {
                                    controller.mapControllerText.text =
                                        suggestion.description.toString();
                                    suggestion.placeId != "";
                                    //   showToast(suggestion.description);

                                    controller.getLatLngFromPlaceId(
                                        suggestion.placeId.toString());

                                    controller.address.value =
                                        suggestion.description.toString();
                                    /* Get.toNamed(AppRoutes.googleMap,arguments: [
                                    controller.currentLat.value,
                                    controller.currentLong.value,
                                    controller.address.value]);*/
                                  }),
                            ),
                          ),
                        ),
                        Spacer(),
                        controller.mapControllerText.text != ""
                            ? Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    controller.mapControllerText.text = "";
                                    controller.mapControllerText.clear();
                                  },
                                  child: const Icon(
                                    Icons.clear,
                                    color: Colors.black87,
                                    size: 25,
                                  ),
                                ))
                            : SizedBox(),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 0,
              color: ColorConstant.addPriceListText,
              height: 1,
            ),
            /*GestureDetector(
              onTap: () {
               // controller.getUserLocation();
              },
              child: SizedBox(
                height: 50,
                child: Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                              padding: const EdgeInsets.only(left: 5, right: 4),
                              child: Icon(
                                Icons.my_location,
                                size: 22,
                                color: ColorConstant.onBoardingBack,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          *//*Image.asset(AppImages.location,
                                  color: ColorConstant.onBoardingBack,
                                  height: SizeConfig.heightMultiplier * 3,
                                  width: SizeConfig.widthMultiplier * 3)),*//*
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              Position position =
                                  await Geolocator.getCurrentPosition(
                                      desiredAccuracy: LocationAccuracy.high);
                              List<Placemark> placemark =
                                  await placemarkFromCoordinates(
                                      position.latitude, position.longitude);
                              controller.initialposition =
                                  LatLng(position.latitude, position.longitude);
                              print(
                                  "the latitude is: ${position.longitude} and th longitude is: ${position.longitude} ");
                              controller.lat.add(position.longitude);
                              controller.long.add(position.longitude);

                              controller.currentLat.value = position.latitude;
                              controller.currentLong.value = position.longitude;
                              showToast(controller.currentLat.value.toString());

                              controller.subLocality.value =
                                  placemark[0].subLocality.toString();
                              controller.address.value = placemark[0]
                                      .street
                                      .toString() +
                                  "," +
                                  placemark[0].thoroughfare.toString() +
                                  "," +
                                  placemark[0].subLocality.toString() +
                                  "," +
                                  placemark[0].locality.toString() +
                                  "," +
                                  placemark[0].administrativeArea.toString() +
                                  "," +
                                  placemark[0].country.toString();
                              controller.city.value =
                                  placemark[0].locality.toString();
                              controller.state.value =
                                  placemark[0].administrativeArea.toString();
                              EasyLoading.dismiss();
                              Get.toNamed(AppRoutes.googleMap, arguments: [
                                controller.currentLat.value,
                                controller.currentLong.value,
                                controller.address.value.toString()
                              ]);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.7,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 2),
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {

                                        },
                                        child: getText(
                                            title: "Current Location",
                                            size: 15,
                                            fontFamily: interMedium,
                                            color: ColorConstant.onBoardingBack,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.7,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 2),
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {},
                                        child: getText(
                                            title: "Using GPS",
                                            size: 13,
                                            fontFamily: interMedium,
                                            color: ColorConstant.onBoardingBack,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),*/
           /* SizedBox(
              height: 2,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 0,
              color: ColorConstant.addPriceListText,
              height: 1,
            ),*/
          ],
        ),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 15,
                    width: 15,
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Center(
                    child: getText(
                        title: "My Address",
                        size: 16,
                        fontFamily: interRegular,
                        color: ColorConstant.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ],
      centerTitle: true,
    );
  }
}

import 'dart:convert';
import 'dart:developer';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:senorita/utils/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../../api_config/Api_Url.dart';
import '../../../utils/showcircledialogbox.dart';
import '../model/offers_list_model.dart';

class SalonDetailController extends GetxController {
  final dataFound = false.obs;

  ///Detail data
  final name = "".obs;
  final image = "".obs;
  final experience = "".obs;
  final location = "".obs;
  final expertise = "".obs;
  final categoryName = "".obs;
  final status = "".obs;
  final bio = "".obs;
  final email = "".obs;
  final distance = "".obs;
  final myRating = "".obs;
  final salonLat = ''.obs;
  final salonLng = ''.obs;
  final avg_rating = "".obs;
  final review_count = "".obs;

  String userRating = "";

  final reviewController = TextEditingController();

  final mobile = "".obs;
  final kodagoCard = "".obs;
  final isDetailsLoading = false.obs;
  final selectedTitle = ''.obs;
  final selectedDes = ''.obs;
  // final selectedSliderValue = 0.obs;
  CarouselController carouselController = CarouselController();
  dynamic offerList = [].obs;
  dynamic priceMenuList = [].obs;
  final expertDetailsList = [].obs;

  final spacialOffer = [].obs;
  final offersUrl = "".obs;

  final subCategory = [].obs;

  dynamic argumentData = Get.arguments;
  final isLoading = false.obs;
  final latitude = "".obs;
  final longitude = "".obs;

  final averageRating = "".obs;

  var expertId = "";
  String token = "";

  final photosList = [].obs;

  late TabController _tabController;

  final selectedTabValue = 0.obs;

  ///Details Screen
  final categoryId = "".obs;
  final lat = "".obs;
  final lng = "".obs;

  final getPriceList = [].obs;

  final getRatingList = [].obs;

  @override
  Future<void> onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token").toString();
    //rating = double.parse(_stringValue);
    categoryId.value = Get.arguments[0].toString();
    // lat.value = Get.arguments[1].toString();
    // lng.value = Get.arguments[2].toString();
    print("lat....$lat");
    name.value = "";
    image.value = "";
    experience.value = "";
    expertise.value = "";
    categoryName.value = "";
    bio.value = "";
    location.value = "";
    status.value = "";
    email.value = "";
    mobile.value = "";
    // allOffersApiFunction();
    latitude.value = prefs.getString("lat").toString();
    longitude.value = prefs.getString("long").toString();
    categoryDetailsFunction(
        latitude.value.toString(), longitude.value.toString(), Get.context!);

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }

  precache() async {
    for (int i = 0; i < offerList.length - 1; i++) {
      if (offerList[i]['banner'].toString() != null) {
        final ImageProvider imageProvider =
            NetworkImage(offerList[i]['banner'].toString());
        await precacheImage(imageProvider, Get.context!);
      }
    }
  }

  categoryDetailsFunction(lat, lng, BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    isLoading.value = true;
    var headers = {'Authorization': 'Bearer' + token};
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrls.homeScreenDetails));
    request.fields.addAll({
      'id': categoryId.value.toString(),
      'lat': lat.toString(),
      'lng': lng.toString(),
    });
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse)
        .timeout(const Duration(seconds: 60));
    log(response.body);
    isLoading.value = false;
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result['success'] == true && result['success'] != null) {
        dataFound.value = true;
        getPriceListApiFunction(categoryId.value.toString());
        getUserReviewApiFunction();
        name.value = result['data']['user'] != null
            ? result['data']['user']['name'] ?? ""
            : "";
        status.value = result['data']['status'] ?? "";
        experience.value = result['data']['experience'] ?? "";
        location.value = result['data']['user'] != null
            ? result['data']['user']['address'] ?? ""
            : "";
        kodagoCard.value = result['data']['kodago_card_url'] ?? "";
        bio.value = result['data']['about'] ?? "";
        image.value = result['data']['image_url'] ?? "";
        location.value = result['data']['user'] != null
            ? result['data']['user']['address'] ?? ""
            : "";
        mobile.value = result['data']['user'] != null
            ? result['data']['user']['mobile'] ?? ""
            : "";
        distance.value = result['data']['user'] != null
            ? result['data']['user']['distance'] ?? ""
            : "";
        salonLat.value = result['data']['user'] != null &&
                result['data']['user']['lat'] != null
            ? result['data']['user']['lat']
            : "";
        salonLng.value = result['data']['user'] != null &&
                result['data']['user']['lng'] != null
            ? result['data']['user']['lng']
            : "";

        myRating.value = result['data']['my_rating'] ?? "";
        averageRating.value = result['data']['avg_rating'] ?? "";
        //  showToast(result['data']['my_rating'].toString());
        var avg = result['data']['avg_rating'].toString().replaceAll("", "");

        avg_rating.value = avg.length > 3 ? avg + "" : avg ?? "";
        //showToast(avg_rating.value.toString());
        review_count.value = result['data']['review_count'] ?? "";

        //  showToast(result['data']['my_rating'].toString());

        spacialOffer.value = result['data']['offers'];
        offersUrl.value = result['offer_base_url'];

        //photosList.value =result['data']['prices'];
        for (int i = 0; i < result['expert_images'].length; i++) {
          photosList.add(result['expert_images'][i]['image']);
        }

        // for (int i = 0; i < result['data']['prices'].length; i++) {
        //   selectedSliderValue.value = i;
        //   OfferList model = OfferList(
        //     result['data']['prices'][i]['id'],
        //     result['data']['prices'][i]['expert_id'],
        //     result['data']['prices'][i]['banner'].toString(),
        //
        //   );
        //   photosList.add(model);
        // }

        for (int j = 0; j < result['data']['expert_subcats'].length; j++) {
          SubCategory model = SubCategory(
            result['data']['expert_subcats'][j]['name'],
          );
          subCategory.add(model);
        }
      }
    } else {
      dataFound.value = false;
      EasyLoading.dismiss();
    }
  }

  getPriceListApiFunction(String expertId) async {
    showCircleProgressDialog(Get.context!);
    getPriceList.clear();
    var headers = {'Authorization': 'Bearer' + token};
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrls.getPriceList));
    request.fields.addAll({
      'expert_id': expertId.toString(),
    });

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    log(response.body);

    if (response.statusCode == 200) {
      Get.back();
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result['success'] == true && result['success'] != null) {
        getPriceList.value = result['Items'];
        print("items....${result['items']}");
      }
    } else {
      Get.back();
    }
  }

  submitReviewApiFunction(BuildContext context) async {
    showCircleProgressDialog(context);
    String result = userRating.toString().replaceAll(".0", "");
    print(result); // Output: "4"

    var headers = {'Authorization': 'Bearer' + token};
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrls.submitReview));
    request.fields.addAll({
      'expert_id': categoryId.value.toString(),
      'rating': result,
      'review': reviewController.text.toString(),
    });
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    getPriceList.clear();
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result['success'] == true && result['success'] != null) {
        showToast(result['message']);
        reviewController.text = "";
        categoryDetailsFunction(latitude.value.toString(),
            longitude.value.toString(), Get.context!);
      } else {
        reviewController.text = "";
        showToast(result['message']);
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  getUserReviewApiFunction() async {
    var headers = {'Authorization': 'Bearer' + token};
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrls.getUserReview));
    request.fields.addAll({
      'expert_id': categoryId.value.toString(),
    });

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result['success'] == true && result['success'] != null) {
        for (int i = 0; i < result['list'].length; i++) {
          RatingList model = RatingList(
              result['list'][i]['id'] ?? "",
              result['list'][i]['rating'] ?? "",
              result['list'][i]['review'] ?? "",
              result['list'][i]['created_at'] ?? "",
              result['list'][i]['user_data']["name"] ?? "");
          getRatingList.add(model);
          //print("modeldata"+result['list']);
        }
      }
    }
  }

  openWhatsapp(String number) async {
    var url = "https://wa.me/$number";
    try {
      await launchUrl(Uri.parse(url));
    } on Exception {}
  }
}

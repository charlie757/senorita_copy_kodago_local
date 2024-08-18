import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_profile_screen/controller/expert_profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../UserApp/salon_details_screen/model/offers_list_model.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../helper/getText.dart';
import '../../../../utils/color_constant.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../../../utils/stringConstants.dart';
import '../../../../utils/toast.dart';

class AddPhotosController extends GetxController {
  ///Image Picker
  final imgFile = Rx<File?>(null);
  final imgUrl = ''.obs;
  final listImages = [].obs;
  String token = "";
  String addImageUrl = "";
  final isLoading = false.obs;
  dynamic pathList = [].obs;
  dynamic fileNameList = [].obs;
  final offersList = [].obs;
  String expertId = "";

  final imgUploaded = false.obs;
  final imgPathString = "".obs;

  final percentage = 0.0.obs;
  final imgSize = "".obs;

  final photosList = [].obs;
  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token").toString();
    expertId = prefs.getString("expertId").toString();
    photosList.value = Get.arguments[0]??[];
    super.onInit();
  }

  final picker = ImagePicker();

  showImagePicker(BuildContext context) {
    showModalBottomSheet(
        elevation: 0,
        context: context,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        builder: (builder) {
          return SizedBox(
            height: 150,
            child: Center(
              child: Card(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))
                    //set border radius more than 50% of height and width to make circle
                    ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                pickImage(ImageSource.camera, context);
                                Navigator.pop(context);
                              },
                              child: iconcreation(
                                  Icons.camera_alt, Colors.pink, "Camera")),
                          GestureDetector(
                              onTap: () {
                                pickImage(ImageSource.gallery, context);
                                Navigator.pop(context);
                              },
                              child: iconcreation(
                                  Icons.insert_photo, Colors.purple, "Gallery"))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget iconcreation(IconData icon, Color color, String text) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Icon(
            icon,
            size: 29,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        getText(
            title: text,
            size: 14,
            fontFamily: celiaRegular,
            color: ColorConstant.blackColor,
            fontWeight: FontWeight.w500),
      ],
    );
  }

  Future pickImage(ImageSource source, BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    if (pickedFile != null) {
      imgUrl.value = pickedFile.path;
      addImage(imgUrl.value, context);
      imgFile.value = File(pickedFile.path);
      //imgFile.value=File(int.parse(pickedFile.path.length.toString())-5);
      int filePathLength = pickedFile.path.length;
      // Get the last 5 characters of the file path
      imgPathString.value = pickedFile.path.substring(filePathLength - 10);
      // Convert the length from bytes to megabytes
      double fileSizeInMB = File(pickedFile.path).lengthSync() / (1024 * 1024);
      imgSize.value = fileSizeInMB.toStringAsFixed(2);
      return pickedFile.path;
    } else {
   //   showToast("Error" "No image selected");
    }
  }

  ///LoadData file Api
  addImage(filename, BuildContext context) async {
    imgUploaded.value = true;
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.addPhotoUrl));
    request.fields.addAll({
      'user_id': Get.find<ExpertProfileController>().model.value.data!.user!.id.toString(),
    });
    request.headers.addAll(headers);
    final file =
        await http.MultipartFile.fromPath('expert_image', filename.toString());
    request.files.add(file);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print(response.body);
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      if (result['success'] == true) {
        Future.delayed(const Duration(seconds: 1), () async {
          imgFile.value = null;
          imgUploaded.value = false;
        });
        percentage.value = 1.0 ;
        Get.find<ExpertProfileController>().profileApiFunction().then((value) {
          if(value!=null){
            photosList.value = value['expert_images']??[];
          }
        });
        // allOffersApiFunction();
        print(pathList.toString());
      } else {
        return null;
      }
    } else {
      showToast(result['message'].toString());
    }
  }

  ///LoadData file Api
 Future deleteImageApiFunction(BuildContext context, String id,) async {
    showCircleProgressDialog(context);
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.deletePhotoUrl));
    request.fields.addAll({
      "image_id": id
    });
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print(response.body);
    var result = json.decode(response.body);
    Get.back();
    if (response.statusCode == 200) {
      if (result['success'] == true) {
        return result;
      } else {
        showToast(result['message']);
        return null;
      }
    }
    else
      {
        showToast(result['message']);

      }
  }

  allOffersApiFunction() async {

    isLoading.value = true;
    var headers = {'Authorization': 'Bearer' + token};
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrls.expertAllOffer));
    request.fields.addAll({
      'type': "price",
    });

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    fileNameList.clear();
    if (response.statusCode == 200) {

      isLoading.value = false;
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result['success'] == true && result['success'] != null) {
        for (int i = 0; i < result['offersList'].length; i++) {
          OfferList model = OfferList(
            result['offersList'][i]['id'],
            result['offersList'][i]['expert_id'],
            result['offersList'][i]['banner'],
          );
          fileNameList.add(model);
        }
      }
    }
    else
      {
        EasyLoading.dismiss();
      }
  }
}

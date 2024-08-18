import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:scan/scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:senorita/ScreenRoutes/routes.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../utils/color_constant.dart';

class ScanQrCodeController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  final scannedData = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // Update the scannedData observable with the scanned QR code data
      print("code....${scanData.code}");
      scannedData.value = scanData.code!;
      print(scannedData.value);
      callVerifyScanCodeApiFunction(scannedData.value);
    });
  }

  callVerifyScanCodeApiFunction(String qrCode)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {'Authorization': 'Bearer ${prefs.getString('token')}'};
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiUrls.verifyScanCodeUrl));
    request.fields.addAll({
      'scaner_code': qrCode,
    });
    print({
      'scaner_code': qrCode,
    });
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    log(response.body);
    final result = json.decode(response.body);
    if (response.statusCode == 200 &&result['success'] == true) {
      Get.toNamed(AppRoutes.paymentScreen,arguments: {'scannerCode':scannedData.value,'name':result['data']['name']});
    }
    else {
      Fluttertoast.showToast(
          msg: result['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.redColor,
          textColor: Colors.white,
          fontSize: 14.0);

    }
  }

  final imgFile = Rx<File?>(null);
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
       imgFile.value = imageTemp;
       // scanQRCode(imageTemp);
      getQrCode(imageTemp.path);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  getQrCode(imagePath)async{
    await Scan.parse(imagePath).then((value) {
      print("value....${value}");
      if(value!=null){
        callVerifyScanCodeApiFunction(value) ;
      }
    });
  }
}
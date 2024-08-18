import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:senorita/ScreenRoutes/routes.dart';
import 'package:http/http.dart'as http;
import 'package:senorita/utils/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api_config/Api_Url.dart';
import '../../../../utils/color_constant.dart';

class QRScannerController extends GetxController {
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
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    log(response.body);
    final result = json.decode(response.body);
    if (response.statusCode == 200 &&result['success'] == true) {
      Get.toNamed(AppRoutes.paymentScreen,arguments: {'scannerCode':scannedData.value});
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
}

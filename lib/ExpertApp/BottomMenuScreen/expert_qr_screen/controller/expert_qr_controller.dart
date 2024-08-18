import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:senorita/ScreenRoutes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart'as http;

import '../../../../api_config/Api_Url.dart';
class ExpertQRScannerController extends GetxController {
  ReceivePort port = ReceivePort();
  final downloadStatus =''.obs;
  final downloadProgress = 0.obs;
  final currentDownloadIndex = 0.obs;
  final pdfUrl = ''.obs;
  String? taskId;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  final scannedData = ''.obs;
 final expertQrCode =''.obs;

  @override
  Future<void> onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    expertQrCode.value= prefs.getString('expert_qr_code')??"";
    super.onInit();
  }


  convertImageToUrlApiFunction(var img)async{
   try{
     print(img.path);
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var headers = {'Authorization': 'Bearer ${prefs.getString('token').toString()}',
     // 'Content-Length': img.lengthSync().toString()
     };
     var request =
     http.MultipartRequest('POST', Uri.parse(ApiUrls.storeScanImageUrl));
     final file = await http.MultipartFile.fromPath('scan_image', '/data/user/0/com.app.senoritaApp/app_flutter/qr_code.png');
     request.files.add(file);
     print(file);
     request.headers.addAll(headers);
     var streamedResponse = await request.send();
     var response = await http.Response.fromStream(streamedResponse);
     log(response.body);
     print(response.request);
     if (response.statusCode == 200) {
       final result = json.decode(response.body);
       if (result['success'] == true && result['success'] != null) {
       }
     }
     else
     {
     }

   }catch(e){
     print("dfg${e.toString()}");
   }
  }

  launchURL(final url) async {
    print('url....$url');
    final Uri url1 = Uri.parse(url.toString());
    if (!await launchUrl(url1,mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }



// void onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //
  //     // Update the scannedData observable with the scanned QR code data
  //     scannedData.value = scanData.code!;
  //     Get.toNamed(AppRoutes.paymentScreen);
  //   });
  // }

}

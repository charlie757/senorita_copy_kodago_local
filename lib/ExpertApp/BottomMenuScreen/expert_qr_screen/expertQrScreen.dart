import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_profile_screen/controller/expert_profile_controller.dart';
import 'package:senorita/api_config/Api_Url.dart';
import 'package:senorita/helper/network_image_helper.dart';
import 'package:senorita/utils/toast.dart';
import 'package:share_plus/share_plus.dart';
import '../../../helper/appbar.dart';
import '../../../helper/appimage.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/stringConstants.dart';
import 'controller/expert_qr_controller.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class ExpertQrScreen extends StatefulWidget {
  const ExpertQrScreen({super.key});

  @override
  State<ExpertQrScreen> createState() => _ExpertQrScreenState();
}

class _ExpertQrScreenState extends State<ExpertQrScreen> {

  ReceivePort port = ReceivePort();
  String downloadStatus ='';
  int downloadProgress = 0;
  final currentDownloadIndex = 0;
  final pdfUrl = ''.obs;
  String? taskId;

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  callDownloaderFunction() {
    IsolateNameServer.registerPortWithName(
        port.sendPort, 'downloader_send_port');
    port.listen((dynamic data) {
      int progress = data[2];
      print("progress...$progress");
      downloadProgress = progress;
      if (progress < 99 && progress > 1) {
        downloadStatus = 'running';
      } else if (progress > 99) {
        downloadStatus = 'completed';
        // Platform.isAndroid?
        FlutterDownloader.open(taskId: taskId!);
        showToast('Successfully Saved');
        // launchURL(pdfUrl.value);
      } else {
        downloadStatus = '';
      }
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }


  downloadFile(String url)async{
    String dir = (await getApplicationDocumentsDirectory()).path;
    print("dir...$dir");
    // currentDownloadIndex.value = index;
    pdfUrl.value = url;
    taskId = await FlutterDownloader.enqueue(
      url: url,
      headers: {}, // optional: header send with url (auth token etc)
      savedDir:  Platform.isAndroid?
      '/storage/emulated/0/Download/':
      "$dir/",
      showNotification: true,
      openFileFromNotification: true,
      saveInPublicStorage: true,
    );
  }


  @override
  void initState() {
    callDownloaderFunction();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExpertQRScannerController());
    print(downloadProgress.toString());
    print(downloadStatus);
    return Scaffold(
      appBar: appBar(context, "QR code", () {
        Get.back();
      }),
      backgroundColor: ColorConstant.white.withOpacity(0.4),
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(
            left: 20,
            top: 75,
            right: 20,
          ),
          child: Obx(() =>
              Column(
                children: [
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.only(right: 1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 66,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                        color: ColorConstant.qrViewBack,
                        border: Border.all(color: ColorConstant.qrViewBack),
                        borderRadius:const BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getText(
                            title: "Scan QR code",
                            size: 17,
                            fontFamily: interSemiBold,
                            color: ColorConstant.blackColor,
                            fontWeight: FontWeight.w600),
                        const SizedBox(height: 7),
                        const getText(
                            title: "Lorem Ipsum is simply dummy text of the printing ",
                            size: 13,
                            textAlign: TextAlign.center,
                            fontFamily: interMedium,
                            lineHeight: 1.5,
                            color: ColorConstant.qrViewText,
                            fontWeight: FontWeight.w600),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                  const SizedBox(height: 31),
                  NetworkImageHelper(
                    img: "${ApiUrls.qrCodeBaseUrl}${Get.find<ExpertProfileController>().model.value.data!.user!.qrCodeImage.toString()}",
                    height: 200.0,
                    width: 200.0,
                  ),
                  const SizedBox(height: 37),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap:(){
                            Share.shareUri(Uri.parse("${ApiUrls.qrCodeBaseUrl}${Get.find<ExpertProfileController>().model.value.data!.user!.qrCodeImage.toString()}"),);
                          },
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              children: [Image.asset(
                                height: 17,
                                width: 17,
                                AppImages.imgShareQr,
                                fit: BoxFit.contain,
                              ),
                                const Padding(
                                    padding: EdgeInsets.only(
                                      left: 7,
                                      top: 3,
                                      bottom: 3,
                                    ),
                                    child: getText(
                                        title: "Share QR",
                                        size: 15,
                                        fontFamily: interMedium,
                                        color: ColorConstant.onBoardingBack,
                                        fontWeight: FontWeight.w600)
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: SizedBox(
                            height: 26,
                            child: VerticalDivider(
                              width: 1,
                              thickness: 1,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: ()async{
                            String dir = (await getApplicationDocumentsDirectory()).path;
                            showToast('Downloading...');
                            taskId=  await FlutterDownloader.enqueue(
                              url: "${ApiUrls.qrCodeBaseUrl}${Get.find<ExpertProfileController>().model.value.data!.user!.qrCodeImage.toString()}",
                              headers: {}, // optional: header send with url (auth token etc)
                              savedDir:  Platform.isAndroid?
                              '/storage/emulated/0/Download/':
                              "$dir/",
                              showNotification: true,
                              openFileFromNotification: true,
                              saveInPublicStorage: true,
                            );

                            // capturePng(context, 'download');
                          },
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              children: [
                                Image.asset(
                                  height: 17,
                                  width: 17,
                                  AppImages.imgDownloadQr,
                                  fit: BoxFit.contain,
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(
                                      left: 9,
                                      top: 3,
                                      bottom: 3,
                                    ),
                                    child: getText(
                                        title: "Download QR",
                                        size: 15,
                                        fontFamily: interMedium,
                                        color: ColorConstant.onBoardingBack,
                                        fontWeight: FontWeight.w600)
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
          ),
        ),
      ),
    );
  }

}


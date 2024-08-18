import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:senorita/helper/appimage.dart';
import 'package:senorita/helper/getText.dart';
import 'package:senorita/utils/screensize.dart';
import 'package:senorita/utils/stringConstants.dart';

import '../../../utils/color_constant.dart';
import 'controller/scan_qr_code_controller.dart';

class ScanQrCodeScreen extends GetWidget<ScanQrCodeController> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorConstant.screenBack.withOpacity(0.4),
      body: Container(
        child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    QRView(
                      key: controller.qrKey,
                      onQRViewCreated: controller.onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        borderColor: Colors.green,
                        borderRadius: 10,
                        borderLength: 30,
                        borderWidth: 10,
                        cutOutSize: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                    Positioned(
                      bottom: 0+40,
                      right: MediaQuery.of(context).size.width/5,
                      child: GestureDetector(
                        onTap: (){
                          controller.pickImage();
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: ColorConstant.dot
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppImages.galleryIcon,height: 20,width: 20,),
                              ScreenSize.width(7),
                              const getText(title: 'Upload from gallery',
                                  size: 15, fontFamily: interMedium,
                                  color:ColorConstant.blackLight, fontWeight: FontWeight.w500)
                            ],
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ],
        ),
      ),

    );
  }
}



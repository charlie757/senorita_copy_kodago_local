
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../helper/appimage.dart';
import '../../helper/getText.dart';
import '../../utils/color_constant.dart';
import '../../utils/stringConstants.dart';
import 'controller/help_controller.dart';

class helpScreen extends GetView<helpController> {
  const helpScreen({key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarColor: Colors.black45,
    //     statusBarIconBrightness: Brightness.light
    //     //color set to transperent or set your own color
    //     ));
    return Scaffold(
        appBar: appBar(context, () {
          Get.back();
        }),
        body:  Obx(()=>
            Stack(
              children: [
                WebView(
                  initialUrl: controller.url.value,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    // Store the controller for future use
                    controller.changeUrl(webViewController.currentUrl.toString());
                  },
                  onPageStarted: (url) {
                    controller.loadingPercentage.value = 0;
                  },
                  onProgress: (progress) {
                    controller.loadingPercentage.value = progress;
                  },
                  onPageFinished: (String url) {
                    controller.isLoading.value = false;
                    controller.loadingPercentage.value = 100;
                    // Update the URL in the controller when the page finishes loading
                    controller.changeUrl(url);
                  },
                ),
                if (controller.loadingPercentage.value < 100)
                  LinearProgressIndicator(
                    value: controller.loadingPercentage.value / 100.0,
                  ),
              ],
            ),


        )
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
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 25,
                    width: 25,
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppImages.backIcon,
                      color: Colors.black87,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
                SizedBox(width: 15,),
                controller.helpAndTermsString=="termsCondition"?
                getText(
                    title: "Terms & Condition",
                    size: 16,
                    fontFamily: celiaRegular,
                    color: ColorConstant.blackColor,
                    fontWeight: FontWeight.w500)
                    : controller.helpAndTermsString=="helpSupport"?
                getText(
                    title: "Help & Support",
                    size: 16,
                    fontFamily: celiaRegular,
                    color: ColorConstant.blackColor,
                    fontWeight: FontWeight.w500)
                    :getText(
                    title: "Kodago Card",
                    size: 16,
                    fontFamily: celiaRegular,
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

}

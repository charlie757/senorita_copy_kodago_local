import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../helper/appimage.dart';
import '../../utils/color_constant.dart';
import 'controller/terms_condition_controller.dart';

class TermsConditionScreen extends GetView<TermsConditionController> {
  const TermsConditionScreen({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => Stack(
        children: [
          WebView(
            initialUrl: controller.url.value,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
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
              controller.changeUrl(url);
            },
          ),
          if (controller.loadingPercentage.value < 100)
            LinearProgressIndicator(
              value: controller.loadingPercentage.value / 100.0,
            ),
        ],
      ),
    ));
  }
}

import 'package:flutter/material.dart';

import 'customcircle.dart';

showCircleProgressDialog(BuildContext context) async {
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          child: CustomCircularProgressIndicator(),
          onWillPop: () async {
            return false;
          },
        );
      });
}

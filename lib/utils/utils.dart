import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Utils {
  static hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

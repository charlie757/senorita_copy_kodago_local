import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:senorita/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ScreenRoutes/routes.dart';
import '../utils/stringConstants.dart';
import '../utils/validation.dart';

class ApiConstants {
  static Future post({
    required body,
    required String url,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.fields.addAll(body);
      print(body);
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {}
      print(response.request);
      print(response.statusCode);
      log(response.body);
      final dataAll = json.decode(response.body);
      if (response.statusCode == 200) {
        return dataAll;
      } else {
        if (dataAll['message'] == 'Fail to authenticate token.') {}
        errorSnackBar(dataAll['error'], navigatorKey.currentContext);
        return null;
      }
    } catch (e) {
      if (e is SocketException) {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(const SnackBar(content: Text('No internet')));
      } else if (e is TimeoutException) {
      } else {}
    }
  }

  static Future get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (kDebugMode) {
        log(response.body);
        print(response.request);
      }
      final dataAll = json.decode(response.body);
      if (response.statusCode == 200) {
        return dataAll;
      } else {
        errorSnackBar(dataAll['error'], navigatorKey.currentContext);
        return null;
      }
    } catch (e) {
      if (e is SocketException) {
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        print("Timeout exception: ${e.toString()}");
      } else {
        print("Unhandled exception: ${e.toString()}");
      }
    }
  }

  static Future getWithToken({
    required String url,
    required bool useAuthToken,
    Map<String, dynamic>? queryParameters,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(authToken).toString());
    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${prefs.getString(authToken)}",
      });
      if (kDebugMode) {
        log(response.body);
        print(response.request);
      }

      final dataAll = json.decode(response.body);
      if (response.statusCode == 200) {
        return dataAll;
      } else {
        if (dataAll['message'] == 'Fail to authenticate token.') {
          prefs.clear();
          Get.offAllNamed(AppRoutes.loginScreen);
        }
        if (dataAll['message'] ==
            'Your profile is blocked. Please contact to admin') {
          prefs.clear();
          Get.offAllNamed(AppRoutes.loginScreen);
        }
        errorSnackBar(dataAll['error'], navigatorKey.currentContext);
        return null;
      }
    } catch (e) {
      if (e is SocketException) {
        internetSnackbar();
        print("Socket exception: ${e.toString()}");
      } else if (e is TimeoutException) {
        print("Timeout exception: ${e.toString()}");
      } else {
        print("Unhandled exception: ${e.toString()}");
      }
    }
  }
}

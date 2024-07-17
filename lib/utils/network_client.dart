import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/constant/const.dart';

class DioExceptions {
  static void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

 static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars(); // Clear existing SnackBars
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: primary,
        animation: CurvedAnimation(
          parent: kAlwaysDismissedAnimation,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  static late String message;
  static int statusCode = -1;
  DioExceptions.fromDioError(
      {required DioException dioError, required String? errorFrom}) {
    _prettyPrintError(dioError: dioError, errorFrom: errorFrom);
    if (dioError.error is SocketException) {
      message = 'No Internet Connection';
    } else {
      switch (dioError.type) {
        case DioExceptionType.cancel:
          message = "Request to API server was cancelled";
          break;
        case DioException.connectionTimeout:
          message = "Connection timeout with API server";
          break;
        case DioException.receiveTimeout:
          message = "Receive timeout in connection with API server";
          break;
        case DioExceptionType.badResponse:
          message = _handleError(
            dioError.response?.statusCode,
            dioError.response?.data,
          );
          statusCode = dioError.response?.statusCode ?? -1;
          break;
        case DioException.sendTimeout:
          message = "Send timeout in connection with API server";
          break;
        default:
          message = "Something went wrong";
          break;
      }
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        resate(Get.context!);
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error['message'];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  String errorMessage() => message;

  int errorStatusCode() => statusCode;

  void _prettyPrintError(
      {required DioException dioError, required String? errorFrom}) {
    debugPrint(
        '\x1B[31m${"********************************************************"}\x1B[0m');
    debugPrint('\x1B[31m${"🚨 ERROR exception from: $errorFrom"}\x1B[0m');
    debugPrint(
        '\x1B[31m${"🚨 ERROR it's status Code : ${dioError.response?.statusCode ?? -1}"}\x1B[0m');

    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      String prettyprint = encoder.convert(dioError.response?.data ?? '');
      debugPrint(
          '\x1B[31m${"********************************************************"}\x1B[0m');
      log("🕵️$errorFrom Error Response :\n$prettyprint", name: "Error");
      debugPrint(
          '\x1B[31m🕵️$errorFrom Error Response :\n$prettyprint", name: "Error"\x1B[0m');
      debugPrint(
          '\x1B[31m${"********************************************************"}\x1B[0m');
    } catch (e) {
      log("🕵️ $errorFrom Error Response :\n${dioError.response?.data ?? ''}",
          name: "Error");
      debugPrint(
          '\x1B[31m${"********************************************************"}\x1B[0m');
    }
  }
}

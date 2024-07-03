import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rider/constant/api_key.dart';
import 'package:rider/main.dart';
import 'package:rider/route/app_route.dart';
import 'package:rider/utils/network_client.dart';

class OtpController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;
  TextEditingController otpCon = TextEditingController();

  @override
  void onReady() {}
  Future<dynamic> verifyOtp({required String userId}) async {
    dio.FormData formData = dio.FormData.fromMap({
      'driver_id': userId.toString(),
      'otp': otpCon.text.toString(),
    });
    log('============= Form DAta ${formData.fields}');
    isLoading(true);
    try {
      var response = await dioClient
          .post(
        '${Config.baseUrl}verify_register_otp.php',
        data: formData,
      )
          .then(
        (respo) {
          // var res = jsonDecode(respo);
          print("${respo['status']}-----------------");
          var message = respo['message'];
          try {
            if (respo['status'] == false) {
              DioExceptions.showErrorMessage(Get.context!, message);
              print('Message: $message');
            } else {
              DioExceptions.showMessage(Get.context!, message);

              Get.toNamed(AppRoutes.LOGIN);
            }
          } catch (e) {
            print('Error parsing JSON or accessing message: $e');
          }
        },
      );
    } on dio.DioException catch (e) {
      print("status Code ${e.response?.statusCode}");
      print('Error $e');
      DioExceptions.showErrorMessage(
          Get.context!,
          DioExceptions.fromDioError(dioError: e, errorFrom: "CREATE ACCOUNT")
              .errorMessage());
      isLoading(false);
    } catch (e) {
      isLoading(false);
      if (kDebugMode) {
        print("sign up $e");
      }
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {}

  increment() => count.value++;
}

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/utils/pref.dart';

import '../../../constant/api_key.dart';
import '../../../constant/const.dart';
import '../../../main.dart';
import '../../../route/app_route.dart';
import '../../../utils/network_client.dart';

class ForgotPasswordController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isResendOtpLoading = false.obs;
  TextEditingController emailCon = TextEditingController();
  TextEditingController otpCon = TextEditingController();

  @override
  void onReady() {}

  Future<dynamic> forgotPassword() async {
    await getToken();

    isLoading(true);
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'email': emailCon.text.trim(),
      });
      var response = await dioClient
          .post('${Config.baseUrl}forgot_password.php', data: formData)
          .then(
        (respo) async {
          // var respo = jsonDecode(respo);

          // model = respo['data'].map<CreateAccountModel>((json){
          //   return CreateAccountModel.fromJson(json);
          // }).toList();
          print('object=============$respo');
          var message = respo['message'];
          try {
            if (respo['status'] == false) {
              DioExceptions.showErrorMessage(Get.context!, message);
              print('Message: $message');
            } else {
              await SharedPref.saveString(
                  Config.userId, respo['data']['deriver_id'].toString());
              DioExceptions.showMessage(Get.context!, message);

              // await SharedPref.saveString(Config.status, model.userType);
              Get.toNamed(AppRoutes.FORGOTOTP);
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
          DioExceptions.fromDioError(dioError: e, errorFrom: "Forgot Password")
              .errorMessage());
      isLoading(false);
    } catch (e) {
      isLoading(false);
      if (kDebugMode) {
        print("Forgot Password $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<dynamic> verifyForgotOtp() async {
    await getUserId();

    isLoading(true);
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'driver_id': userId,
        'otp': otpCon.text.trim(),
      });
      var response = await dioClient
          .post('${Config.baseUrl}verify_forgot_otp.php', data: formData)
          .then(
        (respo) async {
          // var respo = jsonDecode(respo);

          // model = respo['data'].map<CreateAccountModel>((json){
          //   return CreateAccountModel.fromJson(json);
          // }).toList();
          print('object=============$respo');
          var message = respo['message'];
          try {
            if (respo['status'] == false) {
              DioExceptions.showErrorMessage(Get.context!, message);
              print('Message: $message');
            } else {
              DioExceptions.showMessage(Get.context!, message);

              // await SharedPref.saveString(Config.status, model.userType);
              Get.toNamed(AppRoutes.RESATEPASSWORD);
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
          DioExceptions.fromDioError(dioError: e, errorFrom: "Forgot Password")
              .errorMessage());
      isLoading(false);
    } catch (e) {
      isLoading(false);
      if (kDebugMode) {
        print("Forgot Password $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<dynamic> resendOtp() async {
    await getUserId();

    isResendOtpLoading(true);
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'user_id': userId,
      });
      var response = await dioClient
          .post('${Config.baseUrl}resend_forgot_otp.php', data: formData)
          .then(
        (respo) async {
          // var respo = jsonDecode(respo);

          // model = respo['data'].map<CreateAccountModel>((json){
          //   return CreateAccountModel.fromJson(json);
          // }).toList();
          print('object=============$respo');
          var message = respo['message'];
          try {
            if (respo['status'] == false) {
              DioExceptions.showErrorMessage(Get.context!, message);
              print('Message: $message');
            } else {
              DioExceptions.showMessage(Get.context!, message);

              // await SharedPref.saveString(Config.status, model.userType);
              Get.toNamed(AppRoutes.FORGOTOTP);
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
          DioExceptions.fromDioError(dioError: e, errorFrom: "Forgot Password")
              .errorMessage());
      isResendOtpLoading(false);
    } catch (e) {
      isResendOtpLoading(false);
      if (kDebugMode) {
        print("Forgot Password $e");
      }
    } finally {
      isResendOtpLoading(false);
    }
  }

  @override
  void onClose() {}

  increment() => count.value++;
}

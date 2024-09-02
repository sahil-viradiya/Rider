import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rider/constant/api_key.dart';
import 'package:rider/main.dart';
import 'package:rider/model/create_account_model.dart';
import 'package:rider/route/app_route.dart';
import 'package:rider/services/firebase_services/auth_services.dart';
import 'package:rider/utils/network_client.dart';
import 'package:rider/utils/pref.dart';

class OtpController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;
  TextEditingController otpCon = TextEditingController();
  var verificationId1 = '';
  RxString mobileNo = ''.obs;
  PostCreateModel? model;

  @override
  void onReady() {
    var data = Get.arguments;
    if (data != null) {
      verificationId1 = data;
    }
  }
  // Future<dynamic> verifyOtp({required String userId}) async {
  //   dio.FormData formData = dio.FormData.fromMap({
  //     'driver_id': userId.toString(),
  //     'otp': otpCon.text.toString(),
  //   });
  //   log('============= Form DAta ${formData.fields}');
  //   isLoading(true);
  //   try {
  //     var response = await dioClient
  //         .post(
  //       '${Config.baseUrl}verify_register_otp.php',
  //       data: formData,
  //     )
  //         .then(
  //       (respo) {
  //         // var res = jsonDecode(respo);
  //         print("${respo['status']}-----------------");
  //         var message = respo['message'];
  //         try {
  //           if (respo['status'] == false) {
  //             DioExceptions.showErrorMessage(Get.context!, message);
  //             print('Message: $message');
  //           } else {
  //             DioExceptions.showMessage(Get.context!, message);

  //             Get.toNamed(AppRoutes.LOGIN);
  //           }
  //         } catch (e) {
  //           print('Error parsing JSON or accessing message: $e');
  //         }
  //       },
  //     );
  //   } on dio.DioException catch (e) {
  //     print("status Code ${e.response?.statusCode}");
  //     print('Error $e');
  //     DioExceptions.showErrorMessage(
  //         Get.context!,
  //         DioExceptions.fromDioError(dioError: e, errorFrom: "CREATE ACCOUNT")
  //             .errorMessage());
  //     isLoading(false);
  //   } catch (e) {
  //     isLoading(false);
  //     if (kDebugMode) {
  //       print("sign up $e");
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  void verifyOtp() async {
    // This should come from the codeSent callback
    final otpCode = otpCon.text
        .trim(); // Assuming otpController is your TextEditingController for OTP input

    AuthService().verifyOtp(
      verificationId: verificationId1,
      otpCode: otpCode,
      onVerificationSuccess: (UserCredential userCredential) {
        log("Navigate to the home screen or next step after successful OTP verification.");
        loadPostCreateModel();
        // Handle navigation or next steps after successful verification
      },
      onVerificationFailed: (String errorMessage) {
        log("Show error message to user: $errorMessage");
         DioExceptions.showErrorMessage(Get.context!, errorMessage);
        // Show error message to the user or handle verification failure
      },
    );
  }

  Future<PostCreateModel?> loadPostCreateModel() async {
    Map<String, dynamic>? jsonMap =
        await SharedPref.readObject('postCreateModel');
    if (jsonMap != null) {
      model = PostCreateModel.fromJson(jsonMap);
      print("PostCreateModel loaded successfully: ${model?.fullName}");
      mobileNo.value = model!.mobileNo.toString();
      signUp(
          context: Get.context!,
          fullName: model?.fullName ?? "",
          email: model?.email ?? "",
          mobileNo: model?.mobileNo ?? "",
          password: model?.password ?? "",
          confirmPassword: model?.confirmPassword ?? "");
      return model;
    }
    print("No PostCreateModel found in SharedPreferences.");
    return null;
  }

  void resendOtp() async {
    const phoneCode = '+91'; // Example country code

    await SharedPref.readObject('postCreateModel');

    log("resend ${model!.mobileNo}");
    AuthService().resendOtp(
      phoneCode: phoneCode,
      mobileNumber: model!.mobileNo,
      onCodeSent: (String verificationId, int? resendToken) {
        log("Navigate to OTP screen or update UI after OTP is resent.");
        verificationId1=verificationId;
        update();
        refresh();
        // Handle navigation or UI update after OTP is resent
      },
      onVerificationCompleted: (PhoneAuthCredential credential) {
        log("Verification completed automatically with credential.");
        // Handle auto verification completion (if applicable)
      },
      onVerificationFailed: (String errorMessage) {
        log("Show error message to user: $errorMessage");
         DioExceptions.showErrorMessage(Get.context!, errorMessage);

        // Show error message to the user or handle resend failure
      },
      onCodeAutoRetrievalTimeout: (String verificationId) {
        log("Auto-retrieval timed out. Prompt user to enter the OTP manually.");
        // Handle timeout scenario
      },
    );
  }
 Future<dynamic> signUp({required BuildContext context,
      required String fullName,
      required String email,
      required String mobileNo,
      required String password,
      required String confirmPassword}) async {
    dio.FormData formData = dio.FormData.fromMap({
       'fullname': fullName.trim(),
      'email': email.trim(),
      'mobile_no': mobileNo.trim(),
      'password': password.trim(),
      'confirm_password': confirmPassword.trim(),
    });
    log('============= Form DAta ${formData.fields}');
    isLoading(true);
    try {
      var response = await dioClient.post(
        '${Config.baseUrl}register.php',
        data: formData,
      );
      print('Response type: ${response.runtimeType}');

      // var response = jsonDecode(response);
      var message = response['message'];
      try {
        if (response['status'] == false) {
          DioExceptions.showErrorMessage(Get.context!, message);
          print('Message: $message');
        } else {
          DioExceptions.showMessage(Get.context!, message);
          // log(" id   ${response['data']['user_id']}");
          // await SharedPref.saveString(
          //     Config.userId, response['data']['user_id'].toString());

          Get.toNamed(AppRoutes.LOGIN);
          
        }
      } catch (e) {
        print('Error parsing JSON or accessing message: $e');
      }
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
        print("sign up-- $e");
      }
    } finally {
      isLoading(false);
    }
  }


  @override
  void onClose() {}

  increment() => count.value++;
}

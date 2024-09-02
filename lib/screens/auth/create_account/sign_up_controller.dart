import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rider/constant/api_key.dart';
import 'package:rider/model/create_account_model.dart';
import 'package:rider/route/app_route.dart';
import 'package:rider/services/firebase_services/auth_services.dart';
import 'package:rider/utils/network_client.dart';
import 'package:rider/utils/pref.dart';

import '../../../main.dart';

class SignUpController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;
  RxBool checkTC = false.obs;
  BuildContext? context;
  CreateAccountModel model = CreateAccountModel();
  PostCreateModel? createAccountModel;

  TextEditingController fullName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conformPassword = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    createAccountModel = PostCreateModel(
        fullName: '',
        email: '',
        mobileNo: '',
        password: '',
        confirmPassword: '');
  }

  @override
  void onReady() {}

   void verifyNumber() async {
    isLoading.value = true;

    const phoneCode = '+91'; // Example country code
    final mobileNo = createAccountModel!
        .mobileNo; // Assuming mobileNoController is your TextEditingController
    void savePostCreateModel(PostCreateModel model) async {
      await SharedPref.saveObject('postCreateModel', model.toJson());
      print("PostCreateModel saved successfully.");
    }

    AuthService().verifyPhoneNumber(
      phoneCode: phoneCode,
      mobileNumber: mobileNo,
      codeSent: (String verificationId, int? resendToken) {
        log("Navigate to OTP screen after code sent.");
        savePostCreateModel(createAccountModel!);
        Get.toNamed(AppRoutes.OTPSCREEN, arguments: verificationId);
        isLoading.value = false;

        // Handle navigation or UI update after code is sent
      },
      onVerificationCompleted: (PhoneAuthCredential credential) {
        log("Auto verification completed.");

        // Handle what happens when verification is completed automatically
      },
      onVerificationFailed: (String errorMessage) {
        log("Show error message to user: $errorMessage");
        DioExceptions.showErrorMessage(Get.context!, errorMessage);
        isLoading.value = false;

        // Show error message to the user or handle failure
      },
      onCodeAutoRetrievalTimeout: (String verificationId) {
        log("Auto retrieval timeout. Please enter the code manually.");
        isLoading.value = false;

        // Handle auto-retrieval timeout
      },
    );
  }

  @override
  void onClose() {}

  increment() => count.value++;
}

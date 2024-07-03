import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/screens/auth/signIn/signIn_Screen.dart';
import 'package:rider/utils/pref.dart';

import 'api_key.dart';

String? token;
Future<String?> getToken() async {
  token = await SharedPref.readString(Config.kAuth);
  print("TOKEN=========>> $token");
  return token;
}

String? userId;
Future<String?> getUserId() async {
  userId = await SharedPref.readString(Config.userId);
  print("USER_ID=========>> $userId");
  return userId;
}

void resate(BuildContext context) async {
  await SharedPref.saveString(Config.kAuth, '');
  // await SharedPref.saveString(Config.userId, '');
  Get.offAll(SignInScreen());
}

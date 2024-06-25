import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/constant/api_key.dart';
import 'package:rider/constant/const.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rider/main.dart';
import 'package:rider/route/app_route.dart';
import 'package:rider/utils/network_client.dart';

class ResatePasswordController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;
  TextEditingController passCon = TextEditingController();
  TextEditingController conPassCon = TextEditingController();

  @override
  void onReady() {}

  Future<dynamic> resatePassword() async {
    await getUserId();

    isLoading(true);
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'driver_id': userId,
        'password': passCon.text,
        'confirm_password': conPassCon.text,
      });
      var response = await dioClient
          .post('${Config.baseUrl}reset_password.php', data: formData)
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


  @override
  void onClose() {}

  increment() => count.value++;
}

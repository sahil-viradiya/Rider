import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:rider/constant/api_key.dart';
import 'package:rider/constant/const.dart';
import 'package:rider/main.dart';
import 'package:dio/dio.dart' as dio;

import 'package:rider/model/start_ride_model.dart';
import 'package:rider/route/app_route.dart';
import 'package:rider/utils/network_client.dart';

class CustomerAddressController extends GetxController {
  final count = 0.obs;
  var selectedRadio = 0.obs;

  RxBool isLoading = false.obs;
  RxBool switchBtn = true.obs;
  RxString issueDes = 'Heavy Traffic Delivery Time Issue'.obs;
  TextEditingController issueDesdetails = TextEditingController();
  RxString delayDes = 'Stuck in Traffic'.obs;
  TextEditingController delayDesdetails = TextEditingController();
  StartRideModel startRideModel = StartRideModel();

  RxDouble pickupLat = 0.0.obs;
  RxDouble pickupLng = 0.0.obs;

  @override
  void onReady() {}

  Future<dynamic> completeRide({required var id}) async {
    isLoading(true);
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'ride_id': id,
      });
      var response = await dioClient
          .post(
        '${Config.baseUrl}ride_completed.php',
        data: formData,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      )
          .then(
        (respo) async {
          // var respo = jsonDecode(respo);
          log("================================${respo['data']}===============");

          var message = respo['message'];
          try {
            if (respo['status'] == false) {
              DioExceptions.showErrorMessage(Get.context!, message);
              print('Message: $message');
            } else {
              DioExceptions.showMessage(Get.context!, message);
              Get.offAllNamed(AppRoutes.HOMESCREEN);
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
          DioExceptions.fromDioError(dioError: e, errorFrom: "start delivery")
              .errorMessage());
      isLoading(false);
    } catch (e) {
      isLoading(false);
      if (kDebugMode) {
        print("start delivery $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<dynamic> issueRide({required var id}) async {
    isLoading(true);
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'ride_id': id,
        'description' : issueDesdetails.text + issueDes.value
      });
      var response = await dioClient
          .post(
        '${Config.baseUrl}issue_ride.php',
        data: formData,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      )
          .then(
        (respo) async {
          // var respo = jsonDecode(respo);
          log("================================${respo['data']}===============");

          var message = respo['message'];
          try {
            if (respo['status'] == false) {
              DioExceptions.showErrorMessage(Get.context!, message);
              print('Message: $message');
            } else {
              DioExceptions.showMessage(Get.context!, message);
              Get.offAllNamed(AppRoutes.HOMESCREEN);
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
          DioExceptions.fromDioError(dioError: e, errorFrom: "start delivery")
              .errorMessage());
      isLoading(false);
    } catch (e) {
      isLoading(false);
      if (kDebugMode) {
        print("start delivery $e");
      }
    } finally {
      isLoading(false);
    }
  }


 Future<dynamic> delayRide({required var id}) async {
    isLoading(true);
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'ride_id': id,
        'description' : issueDesdetails.text + issueDes.value
      });
      var response = await dioClient
          .post(
        '${Config.baseUrl}delay_ride.php',
        data: formData,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      )
          .then(
        (respo) async {
          // var respo = jsonDecode(respo);
          log("================================${respo['data']}===============");

          var message = respo['message'];
          try {
            if (respo['status'] == false) {
              DioExceptions.showErrorMessage(Get.context!, message);
              print('Message: $message');
            } else {
              DioExceptions.showMessage(Get.context!, message);
              Get.offAllNamed(AppRoutes.HOMESCREEN);
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
          DioExceptions.fromDioError(dioError: e, errorFrom: "start delivery")
              .errorMessage());
      isLoading(false);
    } catch (e) {
      isLoading(false);
      if (kDebugMode) {
        print("start delivery $e");
      }
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {}

  increment() => count.value++;
}

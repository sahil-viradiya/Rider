import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rider/constant/api_key.dart';
import 'package:rider/constant/const.dart';
import 'package:rider/main.dart';
import 'package:rider/model/ride_model.dart';
import 'package:rider/utils/network_client.dart';

class RequestController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;

  late List<Ride> ride;

  @override
  void onInit() {
    ride = [];
    super.onInit();
    getAllRide();
  }

  Future<dynamic> getAllRide() async {
    await getToken();
    isLoading(true);
    try {
      var response = await dioClient.post('${Config.baseUrl}get_ride.php',
          options: dio.Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      print('Response type: ${response}');

      ride = response['data'].map<Ride>((json){
        return Ride.fromJson(json);
      }).toList();
      debugPrint("============${ride[0].senderName}================");
      // var response = jsonDecode(response);
      var message = response['message'];
      try {
        if (response['status'] == false) {
          DioExceptions.showErrorMessage(Get.context!, message);
          print('Message: $message');
        } else {
          DioExceptions.showMessage(Get.context!, message);
          log(" id   $response");
        }
      } catch (e) {
        print('Error parsing JSON or accessing message: $e');
      }
    } on dio.DioException catch (e) {
      print("status Code ${e.response?.statusCode}");
      print('Error $e');
      DioExceptions.showErrorMessage(
          Get.context!,
          DioExceptions.fromDioError(dioError: e, errorFrom: "All Ride")
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
  void onReady() {}

  @override
  void onClose() {}

  increment() => count.value++;
}

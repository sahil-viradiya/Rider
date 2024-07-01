import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rider/constant/api_key.dart';
import 'package:rider/constant/const.dart';
import 'package:rider/main.dart';
import 'package:rider/model/order_history_model.dart';
import 'package:rider/utils/network_client.dart';

class OrderHistoryController extends GetxController {
  RxBool isLoading = false.obs;
  List<OrderHistoryModel> model = [];

  @override
  void onReady() {
    
    orderHistory();
  }

  Future<dynamic> orderHistory() async {
    await getToken(); 
    isLoading(true);
    try {
      /*dio.FormData formData = dio.FormData.fromMap({
        'ride_id': id,
      });*/
      var response = await dioClient
          .post(
        '${Config.baseUrl}order_history.php',
        // data: formData,
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
              model = respo['data'].map<OrderHistoryModel>((json) {
                return OrderHistoryModel.fromJson(json);
              }).toList();
              log("================================${model[0].rideStatus}===============");

              DioExceptions.showMessage(Get.context!, message);
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
}

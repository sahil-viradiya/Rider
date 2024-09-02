
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rider/constant/api_key.dart';
import 'package:rider/constant/const.dart';
import 'package:rider/main.dart';
import 'package:rider/model/order_history_model.dart';
import 'package:rider/utils/app_logger.dart';
import 'package:rider/utils/network_client.dart';

class OrderHistoryController extends GetxController {
  RxBool isLoading = false.obs;
  List<OrderHistoryModel> model = [];
var logger = Logger();

  @override
  void onReady() {
    if (token!=null) {
    orderHistory();
      
    }
  }

 Future<void> orderHistory() async {
   getToken();
  if (token == null) {
    if (kDebugMode) {
      print("Token is null");
    }
    return;
  }
  
  isLoading(true);
  try {
    final response = await dioClient.post(
      '${Config.baseUrl}order_history.php',
      options: dio.Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response == null) {
      throw Exception("Null response received");
    }

    final message = response['message'] as String? ?? "No message available";
    final status = response['status'] as bool? ?? false;
    final data = response['data'] as List<dynamic>?;

    if (!status) {
      DioExceptions.showErrorMessage(Get.context!, message);
      if (kDebugMode) {
        print('Message: $message');
      }
    } else if (data != null) {
      model = data
          .map((json) =>
              OrderHistoryModel.fromJson(json as Map<String, dynamic>))
          .toList();

      if (model.isNotEmpty) {
        AppLogger.logger.i("First order status: ${model[0].rideStatus}");
      }
      DioExceptions.showMessage(Get.context!, message);
    } else {
      DioExceptions.showErrorMessage(Get.context!, "No data available");
    }
  } on dio.DioException catch (e) {
    if (kDebugMode) {
      print("Status Code: ${e.response?.statusCode}");
      print('Error: $e');
    }
    DioExceptions.showErrorMessage(
      Get.context!,
      DioExceptions.fromDioError(dioError: e, errorFrom: "order history")
          .errorMessage(),
    );
  } catch (e) {
    if (kDebugMode) {
      print("Order history error: $e");
    }
  } finally {
    isLoading(false);
  }
}
}

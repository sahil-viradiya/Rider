import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rider/constant/api_key.dart';
import 'package:rider/constant/const.dart';
import 'package:rider/main.dart';
import 'package:rider/model/ride_accept_model.dart';
import 'package:rider/model/ride_model.dart';
import 'package:rider/route/app_route.dart';
import 'package:rider/screens/orders/orders_controller.dart';
import 'package:rider/utils/app_logger.dart';
import 'package:rider/utils/network_client.dart';
import 'package:rider/widget/request_item_widget.dart';

class RequestController extends GetxController {
  final orderController = Get.put(OrdersController());
  final count = 0.obs;
  RxBool isLoading = false.obs;
  var acceptLoading = <int, bool>{}.obs;
  var rejectLoading = <int, bool>{}.obs;
  var isAccepted = <int, bool>{}.obs;

  RxList<Ride> ride = RxList([]);
  Rxn<RideAcceptModel> rideAcceptModel = Rxn<RideAcceptModel>();
  RxList filterList = [].obs;
  @override
  void onInit() {
    super.onInit();
    getAllRide();
  }

  Future<dynamic> getAllRide() async {
    await getToken();
    isLoading(true);
    try {
      var response = await dioClient.post('${Config.baseUrl}ride_requests.php',
          options: dio.Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      ride.value = response['data'].map<Ride>((json) {
        return Ride.fromJson(json);
      }).toList();
      filterList.addAll(ride);
      debugPrint("============${ride[0].senderName}================");
      // var response = jsonDecode(response);
      var message = response['message'];
      try {
        if (response['status'] == false) {
          DioExceptions.showErrorMessage(Get.context!, message);
          print('Message: $message');
        } else {
          DioExceptions.showMessage(Get.context!, message);
        }
      } catch (e) {
        print('Error parsing JSON or accessing message: $e');
      }
    } on dio.DioException catch (e) {
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

  Future<void> acceptRide({required int id, required int index}) async {
    acceptLoading[index] = true;

    try {
      final response = await dioClient.post(
        '${Config.baseUrl}ride_accept.php',
        data: dio.FormData.fromMap({'ride_id': id}),
        options: dio.Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final message = response['message'];
      final status = response['status'];

      if (!status) {
        DioExceptions.showErrorMessage(Get.context!, message);
      } else {
        final rideAcceptData = response['data'];
        AppLogger.logger.i(rideAcceptData);
        rideAcceptModel.value = RideAcceptModel.fromJson(rideAcceptData);
        AppLogger.logger
            .d("rideAcceptModel: ${rideAcceptModel.value?.itemDetails}");
        DioExceptions.showMessage(Get.context!, message);
      }
    } on dio.DioException catch (e) {
      DioExceptions.showErrorMessage(
        Get.context!,
        DioExceptions.fromDioError(dioError: e, errorFrom: "All Ride")
            .errorMessage(),
      );
    } finally {
      acceptLoading[index] = false;
    }
  }

  Future<dynamic> rideReject({required final id, required final index}) async {
    await getToken();
    dio.FormData formData = dio.FormData.fromMap({
      'ride_id': id,
    });

    try {
      // Set loading to true for UI update
      rejectLoading[index] = true;

      // Perform the network request
      var response = await dioClient.post('${Config.baseUrl}ride_reject.php',
          data: formData,
          options: dio.Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      var message = response['message'];

      // Check the response status
      if (response['status'] == false) {
        DioExceptions.showErrorMessage(Get.context!, message);
        print('Message: $message');
      } else {
        DioExceptions.showMessage(Get.context!, message);

        // First, remove the item from filterList

        update();
        log("id $response");
      }
    } on dio.DioException catch (e) {
      print("status Code ${e.response?.statusCode}");
      print('Error $e');
      DioExceptions.showErrorMessage(
          Get.context!,
          DioExceptions.fromDioError(dioError: e, errorFrom: "reject Ride")
              .errorMessage());
    } catch (e) {
      if (kDebugMode) {
        print("Reject Ride $e");
      }
    } finally {
      // Reset loading state
      rejectLoading[index] = false;
    }
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  increment() => count.value++;
}

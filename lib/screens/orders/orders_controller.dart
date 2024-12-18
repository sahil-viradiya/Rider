import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:rider/constant/api_key.dart';
import 'package:rider/constant/const.dart';
import 'package:rider/main.dart';
import 'package:rider/model/start_ride_model.dart';
import 'package:rider/route/app_route.dart';
import 'package:rider/utils/network_client.dart';

class OrdersController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;

  StartRideModel startRideModel = StartRideModel();
  Rxn<StartRideModel> startModel = Rxn<StartRideModel>();

  Future<dynamic> startDelivery({required var id}) async {
    isLoading(true);
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'ride_id': id,
      });
      var response = await dioClient
          .post(
        '${Config.baseUrl}start_delivery.php',
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
            } else {
              startRideModel = StartRideModel.fromJson(respo['data']);
              // customerAddressController.pickupLat.value = double.parse(
              //     customerAddressController.startRideModel.pickUpLatitude
              //         .toString());
              // customerAddressController.pickupLng.value = double.parse(
              //     customerAddressController.startRideModel.pickUpLongitude
              // .toString());
              DioExceptions.showMessage(Get.context!, message);
              log("=====================Customer Response===========$startRideModel===============");
              Get.toNamed(AppRoutes.CUSTOMER_ADDRESS, arguments: [
                double.parse(startRideModel.pickUpLatitude.toString()),
                double.parse(startRideModel.pickUpLongitude.toString()),
                double.parse(startRideModel.dropOffLatitude.toString()),
                double.parse(startRideModel.dropOffLongitude.toString())
              ]);
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
  void onReady() {}

  @override
  void onClose() {}

  increment() => count.value++;
}

import 'package:dio/dio.dart' as dio;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rider/constant/api_key.dart';
import 'package:rider/constant/const.dart';
import 'package:rider/main.dart';
import 'package:rider/route/app_route.dart';
import 'package:rider/screens/home/home_screen.dart';
import 'package:rider/utils/network_client.dart';

class WithdrawamountController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;

  final TextEditingController amountCon = TextEditingController();
  final TextEditingController holderNameCon = TextEditingController();
  final TextEditingController accountNumberCon = TextEditingController();
  final TextEditingController ifscCodeCon = TextEditingController();
  final TextEditingController bankNameCon = TextEditingController();
  final TextEditingController branchNameCon = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var amt;
  @override
  void onReady() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args?.containsKey('walletBalance') == true) {
      amt = args?['walletBalance'];
      update();
    }
  }

  Future<void> withDwawAmount() async {
    try {
      isLoading.value = true;
      final response = await dioClient.post(
        '${Config.baseUrl}driver_withdrawal_amount.php',
        data: dio.FormData.fromMap({
          "amount": amountCon.text ?? '',
          "holderName": holderNameCon.text ?? '',
          "bankName": bankNameCon.text ?? '',
          "accountNumber": accountNumberCon.text ?? '',
          "ifscCode": ifscCodeCon.text ?? '',
          "branceName": branchNameCon.text ?? '',
        }),
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer ${token ?? ''}',
          },
        ),
      );
      if (response['status'] == true) {
        DioExceptions.showMessage(Get.context!, response['message']);
        Get.offUntil(
            GetPageRoute(page: () => const HomeScreen()),
            (route) =>
                route.isFirst || route.settings.name == AppRoutes.HOMESCREEN);
      }
    } on dio.DioException catch (e) {
      DioExceptions.showErrorMessage(
        Get.context!,
        DioExceptions.fromDioError(
          dioError: e,
          errorFrom: "GET TRANSACTION HISTORY",
        ).errorMessage(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {}

  increment() => count.value++;
}

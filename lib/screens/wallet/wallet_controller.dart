import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:rider/constant/api_key.dart';
import 'package:rider/constant/const.dart';
import 'package:rider/main.dart';
import 'package:rider/model/transcation_history_model.dart';
import 'package:rider/model/wallet_balance_model.dart';
import 'package:rider/utils/network_client.dart';

class WalletController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<WalletBalanceModel> walletBalanceModel = WalletBalanceModel().obs;
  RxList<TranscationHistoryModel> transcationHistoryModel =
      <TranscationHistoryModel>[].obs;

  @override
  void onReady() {
    fetchWalletBalance();

    super.onReady();
  }

  Future<void> fetchWalletBalance() async {
    isLoading(true);
    try {
      final response = await dioClient.post(
        '${Config.baseUrl}get_driver_wallet_balance.php',
        options: dio.Options(headers: {'Authorization': 'Bearer $token'}),
        data: dio.FormData.fromMap({}),
      );
      walletBalanceModel.value = WalletBalanceModel.fromJson(response['data']);
      DioExceptions.showMessage(Get.context!, response['message']);
    } on dio.DioException catch (e) {
      DioExceptions.showErrorMessage(
          Get.context!,
          DioExceptions.fromDioError(
                  dioError: e, errorFrom: "GET WALLET BALANCE")
              .errorMessage());
    } finally {
      isLoading(false);
    }
  }

  // Future<void> fetchTransactionHistory() async {
  //   isLoading.value = true;
  //   try {
  //     final response = await dioClient.post(
  //       '${Config.baseUrl}get_customer_transaction_history.php',
  //       options: dio.Options(headers: {'Authorization': 'Bearer $token'}),
  //     );
  //     final List<dynamic>? transactionData = response['data'] as List<dynamic>?;
  //     final List<TranscationHistoryModel> transactionHistory = transactionData
  //             ?.map((transaction) => TranscationHistoryModel.fromJson(
  //                 transaction as Map<String, dynamic>))
  //             .toList() ??
  //         <TranscationHistoryModel>[];
  //     transcationHistoryModel.assignAll(transactionHistory);
  //   } on dio.DioException catch (e) {
  //     DioExceptions.showErrorMessage(
  //         Get.context!,
  //         DioExceptions.fromDioError(
  //                 dioError: e, errorFrom: "GET TRANSACTION HISTORY")
  //             .errorMessage());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
   
}

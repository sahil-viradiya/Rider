import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:rider/constant/api_key.dart';
import 'package:rider/constant/const.dart';
import 'package:rider/main.dart';
import 'package:rider/screens/order_history/order_history_controller.dart';
import 'package:rider/utils/network_client.dart';
import 'package:rider/widget/check_internate_connection.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;
RxInt noOfReq = 0.obs;
RxInt noOfRideAccept = 0.obs;
RxInt revanue = 0.obs;
RxString rating = '0'.obs;
  final orderHisCon = Get.put(OrderHistoryController());
@override
  void onInit() {
  MyConnectivity.instance.initialise();
    
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    fetchDashboardData();
  }

    Future<void> fetchDashboardData() async {
    isLoading(true);
    try {
      final response = await dioClient.get(
        '${Config.baseUrl}driver_dashboard.php',
        options: dio.Options(headers: {'Authorization': 'Bearer $token'}),
      );
     noOfReq.value = response['data']['no_of_received_request'];
     noOfRideAccept.value = response['data']['no_of_ride_accept'];
     revanue.value = response['data']['revanue'];
     rating.value = response['data']['star_rating'];
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
  @override
  void onClose() {}

  increment() => count.value++;
}

class StringTitle {
  final String title1;
  final String img1;
  final String img2;
  final String img3;
  final String img4;
  final String title2;
  final String title3;
  final String title4;
  final String count1;
  final String count2;
  final String count3;
  final String count4;

  StringTitle({
    required this.title1,
    required this.title2,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.title3,
    required this.title4,
    required this.count1,
    required this.count2,
    required this.count3,
    required this.count4,
  });
}

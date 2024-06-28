import 'package:get/get.dart';
import 'package:rider/screens/order_history/order_history_controller.dart';

class HomeController extends GetxController {
  final count = 0.obs;

  final orderHisCon = Get.put(OrderHistoryController());

  @override
  void onReady() {}

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

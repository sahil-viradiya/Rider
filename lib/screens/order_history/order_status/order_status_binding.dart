import 'package:get/get.dart';

import 'order_status_controller.dart';

class OrdersStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersStatusController>(() => OrdersStatusController());
  }
}

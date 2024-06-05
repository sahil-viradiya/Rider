import 'package:get/get.dart';

import 'notifiction_controller.dart';


class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
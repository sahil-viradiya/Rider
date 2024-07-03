import 'package:get/get.dart';

import 'customer_address_controller.dart';

class CustomerAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerAddressController>(() => CustomerAddressController());
  }
}

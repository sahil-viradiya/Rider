import 'package:get/get.dart';

class CustomerAddressController extends GetxController {
    final count = 0.obs;
   var selectedRadio = 0.obs;
    @override
    void onInit() {
    super.onInit();
    }

    @override
    void onReady() {}

    @override
    void onClose() {}

    increment() => count.value++;
}

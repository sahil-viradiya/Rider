import 'package:get/get.dart';
import 'package:rider/model/start_ride_model.dart';

class CustomerAddressController extends GetxController {
  final count = 0.obs;
  var selectedRadio = 0.obs;

  StartRideModel startRideModel = StartRideModel();

  RxDouble dropLat = 0.0.obs;
  RxDouble dropLng = 0.0.obs;

  @override
  void onReady() {}

  @override
  void onClose() {}

  increment() => count.value++;
}

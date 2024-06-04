import 'package:get/get.dart';
import 'package:rider/screens/auth/signIn/signIn_controller.dart';


class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}

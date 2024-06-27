import 'package:get/get.dart';
import 'withdrawamount_controller.dart';

class WithdrawamountBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<WithdrawamountController>(() => WithdrawamountController());
    }
}

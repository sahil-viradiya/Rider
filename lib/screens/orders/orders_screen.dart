import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/constant/style.dart';
import 'package:rider/screens/request/request_controller.dart';
import 'package:rider/widget/auth_app_bar_widget.dart';
import 'package:rider/widget/custom_button.dart';
import 'orders_controller.dart';

class OrdersScreen extends GetView<OrdersController> {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RequestController requestController = Get.find();
    var id = Get.arguments;
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(context, "Orders"),
      body: Column(
        children: [
          const Divider(),
          const Gap(14),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              border: Border.all(color: primary),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Text(
                        "Order ID",
                        style: Styles.boldBlack614,
                      ),
                      const Gap(48),
                      Text(
                       requestController.rideAcceptModel.value?.orderId .toString() ?? "",
                        style: Styles.lable414,
                      ),
                    ],
                  ),
                ),
                const Gap(14),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rider Status",
                        style: Styles.boldBlack614,
                      ),
                      const Gap(30),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                           requestController.rideAcceptModel.value?.rideStatus.toString() ?? "",
                              style: Styles.lable414,
                            ),
                            CustomButton(
                              width: 64,
                              height: 25,
                              borderCircular: 3,
                              text: "Update",
                              style: Styles.boldWhite712,
                              fun: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(14),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Order Status",
                        style: Styles.boldBlack614,
                      ),
                      const Gap(30),
                      Text(
                        "Assign to Rider",
                        style: Styles.boldBlue716,
                      )
                    ],
                  ),
                ),
                const Gap(6),
                const Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivery Time",
                            style: Styles.boldBlack614,
                          ),
                          const Gap(6),
                          Text(
                   requestController.rideAcceptModel.value?.deliveryTime.toString() ?? "",
                            style: Styles.lable414,
                          ),
                          // Gap(4),
                          //
                          // Text(
                          //   "04:00 PM to 04:30 PM",
                          //   style: Styles.lable414,
                          // ),
                        ],
                      ),
                      const Spacer(),
                      CustomButton(
                        height: 22,
                        width: 100,
                        borderCircular: 3,
                        style: Styles.boldWhite712,
                        text: "View Delivery",
                        fun: () {},
                      )
                    ],
                  ),
                ),
                const Gap(6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    "Delivery Address",
                    style: Styles.boldBlack614,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  child: Text(
                   requestController.rideAcceptModel.value?.deliveryAddress.toString() ?? "",
                    style: Styles.lable414,
                  ),
                ),
                const Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  child: Text(
                    "Item Details",
                    style: Styles.boldBlack614,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  child: Text(
                requestController.rideAcceptModel.value?.itemDetails.toString() ?? "",
                    style: Styles.lable414,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  child: Obx(() {
                    return CustomButton(
                      isLoading: controller.isLoading.value,
                      height: 35,
                      borderCircular: 6,
                      width: double.infinity,
                      text: "Start Delivery",
                      fun: () {
                        controller.startDelivery(id: id ?? 0);
                        // Get.toNamed(AppRoutes.CUSTOMER_ADDRESS);
                      },
                    );
                  }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

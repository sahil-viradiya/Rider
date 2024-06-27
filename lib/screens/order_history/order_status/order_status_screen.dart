import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/constant/style.dart';
import 'package:rider/route/app_route.dart';
import 'package:rider/widget/auth_app_bar_widget.dart';
import 'package:rider/widget/custom_button.dart';
import 'order_status_controller.dart';

class OrdersStatusScreen extends GetView<OrdersStatusController> {
  const OrdersStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(context, "Orders"),
      body: Padding(
        padding: const EdgeInsets.only(right: 12, left: 12, bottom: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(),
              const Gap(14),
              Container(
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
                            "${controller.model.orderId}",
                            style: Styles.lable414,
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Status",
                            style: Styles.boldBlack614,
                          ),
                          const Gap(25),
                          Text(
                            "${controller.model.rideStatus}",
                            style: Styles.boldBlack614.copyWith(color: primary),
                          ),
                        ],
                      ),
                    ),
                    const Gap(4),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Time",
                            style: Styles.boldBlack614,
                          ),
                          const Gap(6),
                          Text(
                            "${controller.model.orderTime}",
                            style: Styles.lable414,
                          ),
                          const Gap(4),
                        ],
                      ),
                    ),
                    const Gap(4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        "Delivery Address",
                        style: Styles.boldBlack614,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 4),
                      child: Text(
                        "${controller.model.deliveryAddress}",
                        style: Styles.lable414,
                      ),
                    ),
                    const Divider(),
                    const Gap(4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          Text(
                            "Order Pick Up Time",
                            style: Styles.boldBlack614,
                          ),
                          const Gap(25),
                          Text(
                            "${controller.model.orderPickUpTime}",
                            style: Styles.lable414,
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Picked Up at",
                            style: Styles.boldBlack614,
                          ),
                          const Gap(25),
                          Text(
                            "${controller.model.orderPickedUpAt}",
                            style: Styles.lable414,
                          ),
                        ],
                      ),
                    ),
                    const Gap(4),
                    const Divider(
                      color: primary,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivery Time",
                            style: Styles.boldBlack614,
                          ),
                          const Gap(6),
                          Text(
                            "${controller.model.deliveryTime}",
                            style: Styles.lable414,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        "Delivery Address",
                        style: Styles.boldBlack614,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 4),
                      child: Text(
                        "${controller.model.deliveryAddress}",
                        style: Styles.lable414,
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 4),
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
                        "${controller.model.itemDetails}",
                        style: Styles.lable414,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      child: CustomButton(
                        height: 35,
                        borderCircular: 6,
                        width: double.infinity,
                        text: "Start Delivery",
                        fun: () {
                          Get.toNamed(AppRoutes.WITHDRAW_AMOUNT);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

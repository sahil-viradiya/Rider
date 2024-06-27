import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rider/model/order_history_model.dart';

import '../../constant/app_color.dart';
import '../../constant/my_size.dart';
import '../../constant/style.dart';
import '../../route/app_route.dart';
import '../../widget/auth_app_bar_widget.dart';
import 'order_history_controller.dart';

class OrderHistoryScreen extends GetView<OrderHistoryController> {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(context, "Order History"),
      body: GetBuilder<OrderHistoryController>(
        assignId: true,
        builder: (logic) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 13, left: 13, right: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                const Gap(14),
                Row(
                  children: [
                    Text(
                      'Total Order: ',
                      style: Styles.boldBlack612,
                    ),
                    Text(
                      '122',
                      style: Styles.boldBlack612.copyWith(color: primary),
                    ),
                  ],
                ),
                const Gap(10),
                Obx(() {
                  return controller.isLoading.value == true
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Gap(Get.height / 3),
                            const CircularProgressIndicator(
                              color: primary,
                            ),
                          ],
                        ))
                      : controller.model.isEmpty
                          ? Center(
                              child: Text(
                                "Data Is Empty",
                                textAlign: TextAlign.center,
                                style: Styles.boldBlue614,
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: controller.model.length,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.ORDERSTATUS,arguments: controller.model[index]);
                                  },
                                  child: transcation(
                                      context: context,
                                      model: controller.model[index]),
                                ),
                              ),
                            );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget transcation(
    {required OrderHistoryModel model, required BuildContext context}) {
  Color getRideStatusColor({required String status}) {
    switch (status.toLowerCase()) {
      case 'pending':
        return greenolive;
      case 'accept':
        return greenolive;
      case 'completed':
        return green;
      case 'rejected':
        return red;
      default:
        return primary;
    }
  }

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    margin: const EdgeInsets.only(bottom: 6),
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFFA78430)),
      boxShadow: const [
        BoxShadow(
          color: Colors.white60,
          blurRadius: 8,
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID',
              style: Styles.boldBlack612,
            ),
            Gap(MySize.size6!),
            Text(
              model.orderId.toString(),
              style: Styles.lable414,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("${model.rideDate}",
                style: Styles.lable414.copyWith(fontSize: 10)),
            Gap(MySize.size6!),
            Text(
              "${model.rideStatus}",
              style: Styles.lable414.copyWith(
                  fontSize: 10,
                  color:
                      getRideStatusColor(status: model.rideStatus.toString()),
                  fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    ),
  );
}

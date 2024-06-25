import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 13,left: 13,right: 13),
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
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) =>
                    InkWell(onTap: () {
                      Get.toNamed(AppRoutes.ORDERSTATUS);

                    }, child: transcation(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget transcation(context) {
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
              "9872589963188985",
              style: Styles.lable414,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("30 May 2024", style: Styles.lable414.copyWith(fontSize: 10)),
            Gap(MySize.size6!),
            Text("Pending",
                style:
                    Styles.lable414.copyWith(fontSize: 10, color: greenolive)),
          ],
        )
      ],
    ),
  );
}

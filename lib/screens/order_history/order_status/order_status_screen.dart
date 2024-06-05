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
        padding: const EdgeInsets.only(right: 12,left: 12,bottom: 12),
        child: Column(
          children: [
            const Divider(),
            Gap(14),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: primary),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(14),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),

                    child: Row(
                      children: [
                        Text(
                          "Order ID",
                          style: Styles.boldBlack614,
                        ),
                        Gap(48),
                        Text(
                          "9872589963188985",
                          style: Styles.lable414,
                        ),
                      ],
                    ),
                  ),
                  Gap(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14,),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Status",
                          style: Styles.boldBlack614,
                        ),
                        Gap(25),
                        Text(
                          "Delivered",
                          style: Styles.boldBlack614.copyWith(color: primary),
                        ),
                      ],
                    ),
                  ),
                  Gap(4),

                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14,vertical: 4),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Time",
                          style: Styles.boldBlack614,
                        ),
                        Gap(6),
                        Text(
                          "Mon, 26 Feb 2024",
                          style: Styles.lable414,
                        ),
                        Gap(4),

                        Text(
                          "04:00 PM to 04:30 PM",
                          style: Styles.lable414,
                        ),
                      ],
                    ),
                  ),
                  Gap(4),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),

                    child: Text(
                      "Delivery Address",
                      style: Styles.boldBlack614,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14,vertical: 4),

                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy",
                      style: Styles.lable414,
                    ),
                  ),

                  Divider(),
                  Gap(4),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),

                    child: Row(
                      children: [
                        Text(
                          "Order Pick Up Time",
                          style: Styles.boldBlack614,
                        ),
                        Gap(25),
                        Text(
                          "10:45 PM",
                          style: Styles.lable414,
                        ),
                      ],
                    ),
                  ),
                  Gap(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14,),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Picked Up at",
                          style: Styles.boldBlack614,
                        ),
                        Gap(25),
                        Text(
                          "12:00 PM",
                          style: Styles.lable414,
                        ),
                      ],
                    ),
                  ),
                  Gap(4),




                  Divider(color: primary,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14,vertical: 4),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivery Time",
                          style: Styles.boldBlack614,
                        ),
                        Gap(6),
                        Text(
                          "Mon, 26 Feb 2024",
                          style: Styles.lable414,
                        ),
                        Gap(4),

                        Text(
                          "04:00 PM to 04:30 PM",
                          style: Styles.lable414,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),

                    child: Text(
                      "Delivery Address",
                      style: Styles.boldBlack614,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14,vertical: 4),

                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy",
                      style: Styles.lable414,
                    ),
                  ),

                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14,vertical: 4),

                    child: Text(
                      "Item Details",
                      style: Styles.boldBlack614,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14,),

                    child: Text(
                      "1 Curler",
                      style: Styles.lable414,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14,vertical: 10),

                    child: CustomButton(
                      height: 35,
                      borderCircular: 6,
                      width: double.infinity,
                      text: "Start Delivery",
                      fun: () {
                        Get.toNamed(AppRoutes.CUSTOMER_ADDRESS);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

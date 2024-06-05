import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/constant/style.dart';
import 'package:rider/route/app_route.dart';
import 'package:rider/widget/auth_app_bar_widget.dart';
import 'package:rider/widget/custom_button.dart';
import 'orders_controller.dart';

class OrdersScreen extends GetView<OrdersController> {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(context, "Orders"),
      body: Column(
        children: [
          const Divider(),
          Gap(14),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14),

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
                Gap(14),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14,),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rider Status",
                        style: Styles.boldBlack614,
                      ),
                      Gap(30),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Collected and delivery in Progress",
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
                Gap(14),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14,),

                  child: Row(
                    children: [
                      Text(
                        "Order Status",
                        style: Styles.boldBlack614,
                      ),
                      Gap(30),
                      Text(
                        "Assign to Rider",
                        style: Styles.boldBlue716,
                      )
                    ],
                  ),
                ),
                Gap(6),

                Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14,vertical: 6),

                  child: Row(
                    children: [
                      Column(
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
                      Spacer(),
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
                Gap(6),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),

                  child: Text(
                    "Delivery Address",
                    style: Styles.boldBlack614,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14,vertical: 6),

                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy",
                    style: Styles.lable414,
                  ),
                ),







                Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14,vertical: 6),

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
                  padding: EdgeInsets.symmetric(horizontal: 14,vertical: 14),

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
    );
  }
}

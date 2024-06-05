import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/constant/app_image.dart';
import 'package:rider/constant/style.dart';
import 'package:rider/route/app_route.dart';
import 'package:rider/widget/app_text_field.dart';
import 'package:rider/widget/auth_app_bar_widget.dart';
import 'package:rider/widget/custom_button.dart';

import 'customer_address_controller.dart';

class CustomerAddressScreen extends GetView<CustomerAddressController> {
  const CustomerAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(context, "Customer Address"),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                const BoxShadow(
                  blurRadius: 8,
                  spreadRadius: 4,
                  color: Colors.black12,
                )
              ],
            ),
            child: CustomButton(
              width: Get.width,
              height: 35,
              borderCircular: 6,
              text: "Start Delivery",
              fun: () {
                _showStartDeliveryDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showStartDeliveryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // contentPadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.all(8),
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          // title: const Text("Start Delivery"),
          content: Container(
            decoration: BoxDecoration(
                border: Border.all(color: primary),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(10),
                SvgPicture.asset(AppImage.INFO_BIG),
                Gap(14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting",
                    style: Styles.lable414,
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      height: 32,
                      width: 100,
                      borderCircular: 6,
                      text: "Confirm",
                      style: Styles.boldwhite712,
                      fun: () {
                        Navigator.of(context).pop(); // Close the dialog
                        _showBottomSheet(context); // Show the bottom sheet
                      },
                    ),
                    Gap(12),
                    CustomButton(
                      height: 32,
                      width: 100,
                      color: Color(0xFFE5E5E5),
                      borderCircular: 6,
                      text: "Cancle",
                      style: Styles.boldBlack712,
                      fun: () {},
                    ),
                  ],
                ),
                Gap(12)
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                color: primary,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Text(
                        "Order ID",
                        style: Styles.boldBlack612,
                      ),
                      Gap(14),
                      Text(
                        "9872589963188985",
                        style: Styles.lable414,
                      ),
                      Spacer(),
                      SvgPicture.asset(AppImage.PHONE),
                      Gap(12),
                      SvgPicture.asset(
                        AppImage.LOCATION,
                        width: 16,
                        height: 16,
                        color: primary,
                      )
                    ],
                  ),
                ),
                Gap(10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Text(
                        "Customer Name",
                        style: Styles.boldBlack612,
                      ),
                      Gap(14),
                      Text(
                        "John",
                        style: Styles.lable414,
                      ),
                    ],
                  ),
                ),
                Divider(),
                Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Text(
                    "Delivery Address",
                    style: Styles.boldBlack614,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 1),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy",
                    style: Styles.lable414,
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gap(8),
                    Expanded(
                      child: CustomButton(
                        height: 32,
                        // width: 100,
                        borderCircular: 6,
                        text: "Delivered",
                        style: Styles.boldwhite712,
                        fun: () {
                          Navigator.of(context).pop(); // Close the dialog
                          _deliver(context);
                        },
                      ),
                    ),
                    Gap(8),
                    Expanded(
                      child: CustomButton(
                        height: 32,
                        // width: 100,
                        borderCircular: 6,
                        text: "Issue",
                        style: Styles.boldwhite712,
                        fun: () {
                          Navigator.of(context).pop(); // Close the dialog
                          _issue(context);
                        },
                      ),
                    ),
                    Gap(8),
                    Expanded(
                      child: CustomButton(
                        height: 32,
                        // width: 100,
                        borderCircular: 6,
                        text: "Delay",
                        style: Styles.boldwhite712,
                        fun: () {
                          Navigator.of(context).pop();
                          _delay(context);// Close the dialog
                        },
                      ),
                    ),
                    Gap(8),
                  ],
                ),
                Gap(8),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deliver(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // contentPadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.all(8),
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          // title: const Text("Start Delivery"),
          content: Container(
            decoration: BoxDecoration(
                border: Border.all(color: primary),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(10),
                SvgPicture.asset(AppImage.INFO_BIG),
                Gap(14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Are you Sure you want to mark this Order as Delivered?",
                    style: Styles.lable414,
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      height: 32,
                      width: 100,
                      borderCircular: 6,
                      text: "Confirm",
                      style: Styles.boldwhite712,
                      fun: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                    Gap(12),
                    CustomButton(
                      height: 32,
                      width: 100,
                      color: Color(0xFFE5E5E5),
                      borderCircular: 6,
                      text: "Cancle",
                      style: Styles.boldBlack712,
                      fun: () {},
                    ),
                  ],
                ),
                Gap(12)
              ],
            ),
          ),
        );
      },
    );
  }

  void _issue(BuildContext context) {
    final titles = [
      'Heavy Traffic Delivery Time Issue',
      'Address Not Found',
      'Customer Door Closed',
      'Customer Not Accepting the Order',
      'Customer Blames He Didn’t Place an Order',
      'Other'
    ];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // contentPadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.all(8),
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          // title: const Text("Start Delivery"),
          content: Container(
            decoration: BoxDecoration(
                border: Border.all(color: primary),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List<Widget>.generate(6, (int index) {
                    return Obx(() => RadioListTile<int>(
                          activeColor: primary,
                          controlAffinity: ListTileControlAffinity.trailing,
                          title: Text(
                            titles[index],
                            style: Styles.lable414,
                          ),
                          value: index,
                          groupValue: controller.selectedRadio.value,
                          onChanged: (int? value) {
                            controller.selectedRadio.value = value!;
                          },
                        ));
                  }),
                ),
                Gap(8),

                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      "Description",
                      style: Styles.boldBlack612,
                    ),
                  ),
                ),
                Gap(8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),

                  child: CustomTextFormFieldWidget(
                    minLine: 5,
                    maxLine: 5,
                  ),
                ),

                Divider(),
                Gap(8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      height: 32,
                      width: 100,
                      borderCircular: 6,
                      text: "Confirm",
                      style: Styles.boldwhite712,
                      fun: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                    Gap(12),
                    CustomButton(
                      height: 32,
                      width: 100,
                      color: Color(0xFFE5E5E5),
                      borderCircular: 6,
                      text: "Back",
                      style: Styles.boldBlack712,
                      fun: () {},
                    ),
                  ],
                ),
                Gap(12)

              ],
            ),
          ),
        );
      },
    );
  }

  void _delay(BuildContext context) {
    final titles = [
      'Stuck in Traffic',
      'Road Closed Divert New Route',
      'New Delivery Address Diverted By Customer',
      'Other',

    ];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // contentPadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.all(8),
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          // title: const Text("Start Delivery"),
          content: Container(
            decoration: BoxDecoration(
                border: Border.all(color: primary),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List<Widget>.generate(4, (int index) {
                    return Obx(() => RadioListTile<int>(
                      activeColor: primary,
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text(
                        titles[index],
                        style: Styles.lable414,
                      ),
                      value: index,
                      groupValue: controller.selectedRadio.value,
                      onChanged: (int? value) {
                        controller.selectedRadio.value = value!;
                      },
                    ));
                  }),
                ),
                Gap(8),

                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      "Description",
                      style: Styles.boldBlack612,
                    ),
                  ),
                ),
                Gap(8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),

                  child: CustomTextFormFieldWidget(
                    minLine: 5,
                    maxLine: 5,
                  ),
                ),

                Divider(),
                Gap(8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      height: 32,
                      width: 100,
                      borderCircular: 6,
                      text: "Confirm",
                      style: Styles.boldwhite712,
                      fun: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                    Gap(12),
                    CustomButton(
                      height: 32,
                      width: 100,
                      color: Color(0xFFE5E5E5),
                      borderCircular: 6,
                      text: "Back",
                      style: Styles.boldBlack712,
                      fun: () {},
                    ),
                  ],
                ),
                Gap(12)

              ],
            ),
          ),
        );
      },
    );
  }

}

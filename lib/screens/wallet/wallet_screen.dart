import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:rider/screens/wallet/wallet_controller.dart';

import '../../constant/app_color.dart';
import '../../constant/font-family.dart';
import '../../constant/my_size.dart';
import '../../constant/style.dart';
import '../../widget/auth_app_bar_widget.dart';

class WalletScreen extends GetView<WalletController> {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(context, "Wallet"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _withdrawCard(context),
          Gap(MySize.size18!),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'Transaction ',
              style: Styles.boldBlue615,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: 15,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => transcationWallet(context),
            ),
          )
        ],
      ),
    );
  }

  _withdrawCard(BuildContext context) {
    return Stack(
      children: [
        // Main Container
        Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(20),
          width: MySize.safeWidth,
          height: MySize.size186,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFC19F4E), // Start color
                Color(0xFFDEC587), // End color
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Total Revenue',
                    style: Styles.boldWhite414,
                  ),
                  const Spacer(),
                  Text(
                    'Hello, Denny',
                    style: Styles.boldWhite614,
                  ),
                ],
              ),
              Gap(MySize.size5!),
              Text(
                "\$ 985989",
                style: Styles.white720,
              ),
              Gap(MySize.size35!),
              // Add your other widgets here if needed
            ],
          ),
        ),
        // Bottom Container
        Positioned(
          left: 12,
          right: 12,
          bottom: 12,
          child: Container(
            height: MySize.size50,
            decoration: const BoxDecoration(
              color: primary, // Assuming primary is defined somewhere
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Center(
                child: Text(
              "Withdraw",
              textAlign: TextAlign.center,
              style: Styles.boldWhite414,
            )),
          ),
        ),
      ],
    );
  }
}

Widget transcationWallet(context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
    margin: const EdgeInsets.only(bottom: 6),
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
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
              'ID: 9873598658',
              style: Styles.boldBlack612,
            ),
            Gap(MySize.size6!),
            Text(
              "Lorem Ipsum is simply dummy text of the printing",
              style: Styles.noramalBlack411,
            ),
          ],
        ),
        Text(
          "+ \$999",
          style: TextStyle(
            color: green,
            fontSize: 12,
            fontFamily: FontFamily.primary,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    ),
  );
}

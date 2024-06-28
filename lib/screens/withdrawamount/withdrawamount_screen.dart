import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/constant/my_size.dart';
import 'package:rider/constant/style.dart';
import 'package:rider/constant/validation.dart';
import 'package:rider/widget/app_text_field.dart';
import 'package:rider/widget/auth_app_bar_widget.dart';
import 'package:rider/widget/custom_button.dart';
import '../../screens/withdrawamount/withdrawamount_controller.dart';

class WithdrawamountScreen extends GetView<WithdrawamountController> {
  const WithdrawamountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarSmall1(context, "Withdraw Amount"),
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _withdrawCard(context),
            const Gap(32),
            //============================Enter Amount For Withdraw======================
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Enter Amount For Withdraw",
                style: Styles.boldBlack614,
                textAlign: TextAlign.left,
              ),
            ),
            Gap(MySize.size4!),
            CustomPasswordTextFormFieldWidget(
              // controller: _controller.passCon,
              validator: ((value) {
                return Validator.validatePassword(value!);
              }),
              // controller: loginBloc.passCon,
              lblTxt: '',
              obscureText: true,
              suffixTap: () {},
            ),
            const Gap(16),

            //============================Account Holder Name======================
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Account Holder Name",
                style: Styles.boldBlack614,
                textAlign: TextAlign.left,
              ),
            ),

            Gap(MySize.size4!),
            CustomPasswordTextFormFieldWidget(
              // controller: _controller.passCon,
              validator: ((value) {
                return Validator.validatePassword(value!);
              }),
              // controller: loginBloc.passCon,
              lblTxt: '',
              obscureText: true,
              suffixTap: () {},
            ),
            //============================Account Number======================
            const Gap(16),

            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Account Number",
                style: Styles.boldBlack614,
                textAlign: TextAlign.left,
              ),
            ),
            Gap(MySize.size4!),
            CustomPasswordTextFormFieldWidget(
              // controller: _controller.passCon,
              validator: ((value) {
                return Validator.validatePassword(value!);
              }),
              // controller: loginBloc.passCon,
              lblTxt: '',
              obscureText: true,
              suffixTap: () {},
            ),
            //============================IFSC Code======================
            const Gap(16),

            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "IFSC Code",
                style: Styles.boldBlack614,
                textAlign: TextAlign.left,
              ),
            ),
            Gap(MySize.size4!),
            CustomPasswordTextFormFieldWidget(
              // controller: _controller.passCon,
              validator: ((value) {
                return Validator.validatePassword(value!);
              }),
              // controller: loginBloc.passCon,
              lblTxt: '',
              obscureText: true,
              suffixTap: () {},
            ),
            const Gap(16),
            const Gap(16),

            CustomButton(
              width: double.infinity,
              height: 35,
              borderCircular: 7,
              text: "Withdraw",
              fun: () {},
            )
          ],
        ),
      ),
    );
  }

  _withdrawCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MySize.safeWidth,
      height: MySize.size150,
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
    );
  }
}

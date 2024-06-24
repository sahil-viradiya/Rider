import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/constant/my_size.dart';
import 'package:rider/constant/style.dart';
import 'package:rider/constant/validation.dart';
import 'package:rider/route/app_route.dart';
import 'package:rider/screens/auth/resate_password/resate_password_controller.dart';
import 'package:rider/widget/app_text_field.dart';
import 'package:rider/widget/auth_app_bar_widget.dart';
import 'package:rider/widget/custom_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final ResatePasswordController _controller =
  Get.put(ResatePasswordController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: primaryWhite,
      appBar: Appbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MySize.getScaledSizeWidth(25)),
          child: Form(
            key: _formKey,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(MySize.size30!),
                Text(
                  'Reset Password',
                  style: Styles.boldBlue720,
                ),
                Gap(MySize.size20!),
                Text(
                  'Welcome to Genie! We are here to help with your work requirements',
                  style: Styles.noramalBlack411,
                  textAlign: TextAlign.center,
                ),
                Gap(MySize.size30!),
                Align(
                  alignment: Alignment.topLeft,
                  child:
                  Text("Password", style: Styles.boldBlack614,
                    textAlign: TextAlign.left,),

                ),
                Gap(MySize.size4!),

                 CustomTextFormFieldWidget(
                  controller: _controller.passCon,
                   validator: (value) {
                     return Validator.validatePassword(value!);
                   },
                  // lblTxt: AppString.resetPassword,
                ),
                Gap(MySize.size12!),
                Align(
                  alignment: Alignment.topLeft,
                  child:
                  Text("Confirm Password", style: Styles.boldBlack614,
                    textAlign: TextAlign.left,),

                ),
                Gap(MySize.size4!),
                 CustomTextFormFieldWidget(
                  controller: _controller.conPassCon,
                   validator: (value) {
                     return Validator.validateConfirmPassword(value!,_controller.passCon.text);
                   },
                ),
                Gap(MySize.size24!),
                Obx(() {
                  return CustomButton(
                      isLoading: _controller.isLoading.value,
                      text: 'Submit',
                      fun: _controller.isLoading.value != true
                          ? () {
                        // Get.toNamed(AppRoutes.RESATEPASSWORD);
                        if (_formKey.currentState!.validate()) {
                          _controller.resatePassword();
                        }
                      }
                          : () {});
                }),
                Gap(MySize.size24!),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.initialRoute);
                  },
                  child: Text(
                    'Back to Login Page',
                    style: Styles.normalBlue612U,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
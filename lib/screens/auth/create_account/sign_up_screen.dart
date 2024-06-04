// ignore_for_file: must_be_immutable


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
import 'package:rider/widget/app_text_field.dart';
import 'package:rider/widget/auth_app_bar_widget.dart';
import 'package:rider/widget/custom_button.dart';

import '../../../constant/app_image.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return Scaffold(
      backgroundColor: primaryWhite,
      appBar: Appbar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: MySize.getScaledSizeWidth(25)),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(MySize.size30!),
                Text(
                  'Create Account',
                  style: Styles.boldBlue720,
                ),
                Gap(MySize.size20!),
                Text(
                  'Welcome to Genie! We are here to help with your work requirements',
                  style: Styles.noramalBlack411,
                  textAlign: TextAlign.center,
                ),
                Gap(MySize.size30!),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: Styles.noramalBlack615,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MySize.getScaledSizeWidth(16)),
                      child: Container(
                        alignment: Alignment.center,
                        height: MySize.size28,
                        width: MySize.size1,
                        color: black,
                      )),
                  Container(
                    alignment: Alignment.center,
                    height: MySize.size30,
                    width: MySize.size78,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: Styles.boldWhite615,
                    ),
                  ),
                ]),

                // _radioBtn(boolValue, context),

                Gap(MySize.size24!),
                //-------------------------------fname------=--------------------------
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Full Name",
                    style: Styles.boldBlack614,
                    textAlign: TextAlign.left,
                  ),
                ),
                Gap(MySize.size4!),
                CustomTextFormFieldWidget(
                  // controller: signUpBloc.fnameCon,
                  keyboardType: TextInputType.name,
                  hintRpadding: 17.76,
                  validator: ((value) {
                    return Validator.validateFirstName(value!);
                  }),
                ),
                Gap(MySize.size12!),
                //-------------------------------lname------=--------------------------
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Username",
                    style: Styles.boldBlack614,
                    textAlign: TextAlign.left,
                  ),
                ),
                Gap(MySize.size4!),
                CustomTextFormFieldWidget(
                  keyboardType: TextInputType.name,
                  validator: ((value) {
                    return Validator.validateLastName(value!);
                  }),
                  // controller: signUpBloc.lnameCon,
                  hintRpadding: 17.76,
                ),
                Gap(MySize.size12!),
                //-------------------------------email------=--------------------------
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Email",
                    style: Styles.boldBlack614,
                    textAlign: TextAlign.left,
                  ),
                ),
                Gap(MySize.size4!),
                CustomTextFormFieldWidget(
                  keyboardType: TextInputType.emailAddress,
                  validator: ((value) {
                    return Validator.validateEmails(value!);
                  }),
                  hintRpadding: 17.76,
                ),
                Gap(MySize.size12!),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Mobile Number",
                    style: Styles.boldBlack614,
                    textAlign: TextAlign.left,
                  ),
                ),
                Gap(MySize.size4!),
                CustomTextFormFieldWidget(
                  // keyboardType: TextInputType.emailAddress,
                  validator: ((value) {
                    // return Validator.validateEmails(value!);
                  }),

                  hintRpadding: 17.76,
                ),

                Gap(MySize.size12!),

                //-------------------------------password------=--------------------------
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Password",
                    style: Styles.boldBlack614,
                    textAlign: TextAlign.left,
                  ),
                ),
                Gap(MySize.size4!),
                CustomPasswordTextFormFieldWidget(
                  // controller: signUpBloc.passwordCon,
                  validator: ((value) {
                    return Validator.validatePassword(value!);
                  }),

                  obscureText: true,
                  suffixTap: () {},
                ),
                Gap(MySize.size24!),
                //-------------------------------conf pass------=--------------------------
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Confirm Password",
                    style: Styles.boldBlack614,
                    textAlign: TextAlign.left,
                  ),
                ),
                Gap(MySize.size4!),
                CustomPasswordTextFormFieldWidget(
                  validator: ((value) {}),
                  // controller: signUpBloc.confrimCon,

                  obscureText: true,
                  suffixTap: () {},
                ),
                Gap(MySize.size24!),

                //////////////////////////////////////////////////////////////////////////////////////////// check box------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: primary,
                      visualDensity: const VisualDensity(horizontal: -4),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: const BorderSide(color: primary),
                      value: false,
                      onChanged: (bool? value) {},
                    ),
                    Text(
                      ' I agree with the ',
                      style: Styles.hint610,
                    ),
                    Text(
                      'terms and conditions',
                      style: Styles.normalBlue610U,
                    ),
                  ],
                ),
                Gap(MySize.size10!),
                //----------------------------------------sign up button---------------------------
                CustomButton(
                    text: 'Sign up',
                    fun: () {
                      Get.toNamed(AppRoutes.OTPSCREEN);

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(),));
                      // if (_formKey.currentState!.validate()) {}
                      // ;
                    }),

                Gap(MySize.size24!),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.initialRoute),
                  child: Text(
                    'Already have an account?',
                    style: Styles.normalBlue612U,
                  ),
                ),

                Gap(MySize.size24!),
                Row(
                  children: [
                    const Expanded(
                      child: DottedLine(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        //lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: Colors.black,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MySize.getScaledSizeWidth(16.00)),
                      child: Text(
                        'OR',
                        style: Styles.noramalBlack614,
                      ),
                    ),
                    const Expanded(
                      child: DottedLine(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        //lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: Colors.black,
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                    ),
                  ],
                ),
                Gap(MySize.size10!),
                Container(
                  alignment: Alignment.center,
                  height: MySize.size50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    border: Border.all(
                      color: primary,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImage.FACEBOOK,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        "  Login With Facebook",
                        style: Styles.boldBlue712,
                      ),
                    ],
                  ),
                ),
                Gap(MySize.size10!),
                Container(
                  alignment: Alignment.center,
                  height: MySize.size50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    border: Border.all(
                      color: primary,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImage.GOOGLE,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        "  Login With Google",
                        style: Styles.boldBlue712,
                      ),
                    ],
                  ),
                ),
                Gap(MySize.size30!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

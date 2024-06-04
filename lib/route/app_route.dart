

import 'package:get/get.dart';
import 'package:rider/screens/auth/create_account/sign_up_screen.dart';
import 'package:rider/screens/auth/forgot_password/forgot_otp_screen.dart';
import 'package:rider/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:rider/screens/auth/otp/otp_screen.dart';
import 'package:rider/screens/auth/resate_password/resate_password_screen.dart';
import 'package:rider/screens/auth/signIn/signIn_Screen.dart';

class AppRoutes {
  static String SPLASHSCREEN = '/splash_screen';

  static String LOGIN = '/login_screen';
  static String FORGOTPASSWORD = '/forgot_password';
  static String FORGOTOTP = '/forgot_otp';
  static String RESATEPASSWORD = '/resate_password';
  static String SIGNUPSCREEN = '/create_account';
  static String initialRoute = '/login_screen';
  static String OTPSCREEN = '/otp_screen';
  static String HOMESCREEN = '/home_screen';
  static String PICKUPSCREEN = '/pickUp_screen';
  static String SETCURRENTLOCATION = '/set_CURRENT_location';
  static String SETCURRENTDROPTLOCATION = '/set_CURRENT_drop_location';
  static String SETPICKUPLOCATION = '/set_pickUp_location';
  static String SETDROPLOCATION = '/set_drop_location';
  static String ADDRESSDETAILS = '/address_details';
  static String DROPADDRESSDETAILS = '/drop_address_details';
  static String DROPSCREEN = '/drop_screen';
  static String PICKUPORSENDANYTHING = '/pickup_or_send_any';
  static String CHECKOUT = '/checkout';
  static String PAYMENT = '/payment';
  static String ADDRESS = '/address';
  static String PAYMENTOPTION = '/payment_option';
  static String ADDNEWCARD = '/add_new_card';
  static String LINKACCOUNTSCREEN = '/link_account_screen';

  static List<GetPage> pages = [
    // GetPage(
    //   name: splashScreen,
    //   page: () => const SplashScreen(),
    //   bindings: [
    //     SplashBinding(),
    //   ],

    GetPage(
      name: initialRoute,
      page: () => SignInScreen(),
      bindings: const [
        // SplashBinding(),
      ],
    ),GetPage(
      name: FORGOTPASSWORD,
      page: () => ForgotPasswordScreen(),
      bindings: const [
        // SplashBinding(),
      ],
    ),GetPage(
      name: FORGOTOTP,
      page: () => ForgotOtpScreen(),
      bindings: const [
        // SplashBinding(),
      ],
    ),GetPage(
      name: RESATEPASSWORD,
      page: () => ResetPasswordScreen(),
      bindings: const [
        // SplashBinding(),
      ],
    ),GetPage(
      name: SIGNUPSCREEN,
      page: () => SignUpScreen(),
      bindings: const [
        // SplashBinding(),
      ],
    ),GetPage(
      name: OTPSCREEN,
      page: () => OtpScreen(),
      bindings: const [
        // SplashBinding(),
      ],
    ),

  ];
}
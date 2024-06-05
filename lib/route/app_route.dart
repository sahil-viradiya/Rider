

import 'package:get/get.dart';
import 'package:rider/screens/auth/create_account/sign_up_screen.dart';
import 'package:rider/screens/auth/forgot_password/forgot_otp_screen.dart';
import 'package:rider/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:rider/screens/auth/otp/otp_screen.dart';
import 'package:rider/screens/auth/resate_password/resate_password_screen.dart';
import 'package:rider/screens/auth/signIn/signIn_Screen.dart';
import 'package:rider/screens/customer_address/customer_address_binding.dart';
import 'package:rider/screens/customer_address/customer_address_screen.dart';
import 'package:rider/screens/home/home_binding.dart';
import 'package:rider/screens/home/home_screen.dart';
import 'package:rider/screens/orders/orders_binding.dart';
import 'package:rider/screens/orders/orders_screen.dart';
import 'package:rider/screens/request/request_binding.dart';
import 'package:rider/screens/request/request_screen.dart';

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
  static String REQUEST = '/request';
  static String ORDER = '/order';
  static String CUSTOMER_ADDRESS = '/customer_address';

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
      name: CUSTOMER_ADDRESS,
      page: () => const CustomerAddressScreen(),
      bindings:  [
        CustomerAddressBinding(),
      ],
    ),GetPage(
      name: ORDER,
      page: () => const OrdersScreen(),
      bindings:  [
        OrdersBinding(),
      ],
    ),GetPage(
      name: REQUEST,
      page: () => const RequestScreen(),
      bindings:  [
        RequestBinding(),
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
      page: () => const ResetPasswordScreen(),
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
    ),GetPage(
      name: HOMESCREEN,
      page: () => const HomeScreen(),
      bindings:  [
        HomeBinding(),
      ],
    ),

  ];
}
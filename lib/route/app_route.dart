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
import 'package:rider/screens/notification/notifiction_binding.dart';
import 'package:rider/screens/order_history/order_history_binding.dart';
import 'package:rider/screens/order_history/order_history_screen.dart';
import 'package:rider/screens/order_history/order_status/order_status_binding.dart';
import 'package:rider/screens/orders/orders_binding.dart';
import 'package:rider/screens/orders/orders_screen.dart';
import 'package:rider/screens/request/request_binding.dart';
import 'package:rider/screens/request/request_screen.dart';
import 'package:rider/screens/wallet/wallet_binding.dart';
import 'package:rider/screens/withdrawamount/withdrawamount_binding.dart';
import 'package:rider/screens/withdrawamount/withdrawamount_screen.dart';

import '../screens/notification/notifiction_screen.dart';
import '../screens/order_history/order_status/order_status_screen.dart';
import '../screens/wallet/wallet_screen.dart';

class AppRoutes {
  static String SPLASHSCREEN = '/splash_screen';

  static String LOGIN = '/login_screen';
  static String NOTIFICATION = '/notification_screen';
  static String WALLET = '/wallet_screen';
  static String ORDERHISTORY = '/orderhistory_screen';
  static String ORDERSTATUS = '/orderstatus_screen';
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
  static String WITHDRAW_AMOUNT = '/withdraw_amount';

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
    ),
    GetPage(
      name: CUSTOMER_ADDRESS,
      page: () => const CustomerAddressScreen(),
      bindings: [
        CustomerAddressBinding(),
      ],
    ),
    GetPage(
      name: WITHDRAW_AMOUNT,
      page: () => const WithdrawamountScreen(),
      bindings: [
        WithdrawamountBinding(),
      ],
    ),
    GetPage(
      name: ORDER,
      page: () => const OrdersScreen(),
      bindings: [
        OrdersBinding(),
      ],
    ),
    GetPage(
      name: REQUEST,
      page: () => const RequestScreen(),
      bindings: [
        RequestBinding(),
      ],
    ),
    GetPage(
      name: FORGOTPASSWORD,
      page: () => ForgotPasswordScreen(),
      bindings: const [
        // SplashBinding(),
      ],
    ),
    GetPage(
      name: FORGOTOTP,
      page: () => ForgotOtpScreen(),
      bindings: const [
        // SplashBinding(),
      ],
    ),
    GetPage(
      name: RESATEPASSWORD,
      page: () => ResetPasswordScreen(),
      bindings: const [
        // SplashBinding(),
      ],
    ),
    GetPage(
      name: SIGNUPSCREEN,
      page: () => SignUpScreen(),
      bindings: const [
        // SplashBinding(),
      ],
    ),
    GetPage(
      name: OTPSCREEN,
      page: () => OtpScreen(),
      bindings: const [
        // SplashBinding(),
      ],
    ),
    GetPage(
      name: HOMESCREEN,
      page: () => const HomeScreen(),
      bindings: [
        HomeBinding(),
      ],
    ),
    GetPage(
      name: NOTIFICATION,
      page: () => const NotificationScreen(),
      bindings: [
        NotificationBinding(),
      ],
    ),
    GetPage(
      name: WALLET,
      page: () => const WalletScreen(),
      bindings: [
        WalletBinding(),
      ],
    ),
    GetPage(
      name: ORDERHISTORY,
      page: () => const OrderHistoryScreen(),
      bindings: [
        OrderHistoryBinding(),
      ],
    ),
    GetPage(
      name: ORDERSTATUS,
      page: () => const OrdersStatusScreen(),
      bindings: [
        OrdersStatusBinding(),
      ],
    ),
  ];
}

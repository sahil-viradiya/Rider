import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rider/screens/home/home_controller.dart';
import 'package:rider/services/location_servies.dart';
import 'package:rider/utils/api_client.dart';
import 'package:rider/widget/check_internate_connection.dart';
import 'constant/const.dart';
import 'services/notification_handler.dart';
import 'route/app_route.dart';
import 'package:dart_style/dart_style.dart';

RxBool isOn = false.obs;

void main() async {
  // if (defaultTargetPlatform == TargetPlatform.android) {
  //   AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  // }

  WidgetsFlutterBinding.ensureInitialized();
  MyConnectivity.instance.initialise();
  await Firebase.initializeApp();
  await NotificationService.initialize();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logEvent(
    name: 'my_event',
    parameters: {'key': 'value'},
  );
  getToken();
  Get.put(LocationController());
  final formatter = DartFormatter();

  try {
    print(formatter.format("""
    library an_entire_compilation_unit;

    class SomeClass {}
    """));

    print(formatter.formatStatement("aSingle(statement);"));
  } on FormatterException catch (ex) {
    print(ex);
  }


  // String? userID = await getUserId();

  // final dio = Dio();
  // final dioClient = DioClient('https://sos.notionprojects.tech/', dio);

  runApp(const MyApp());
}

final dio = Dio();
final dioClient = DioClient(
  'https://ride.notionprojects.tech/api/customer/',
  dio,
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    startProcess();
    if (token != null && token!.isNotEmpty) {
      Get.put(HomeController());
    }
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    log("message=========${token.toString()} ");

    return ScreenUtilInit(
      designSize: const Size(360, 700),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Redda customer',
          initialRoute: _getInitialRoute(),
          getPages: AppRoutes.pages,
        ),
      ),
    );
  }

  String _getInitialRoute() {
    log("message=========${token.toString()} ");
    if (token != null && token!.isNotEmpty) {
      return AppRoutes.HOMESCREEN; // Home route
    } else {
      return AppRoutes.LOGIN; // Login route
    }
  }

  startProcess() async {
    await requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    // Request location permission
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, check if location services are enabled
      await _checkAndEnableLocationServices();
    } else if (status.isDenied) {
      // Permission denied, show a dialog to request permission again
      _showPermissionDeniedDialog();
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, open app settings
      await openAppSettings();
    }
  }

  Future<void> _checkAndEnableLocationServices() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      bool serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        // Show a dialog to the user if they decline to enable location services
        _showLocationServicesDialog();
      }
    } else {}
  }

  void _showLocationServicesDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text("Location Services Disabled"),
        content: const Text("Please enable location services to use this app."),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _checkAndEnableLocationServices();
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text("Permission Denied"),
        content: const Text("Location permission is required to use this app."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              requestLocationPermission();
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rider/utils/api_client.dart';
import 'constant/const.dart';
import 'route/app_route.dart';


void main()async {
  // if (defaultTargetPlatform == TargetPlatform.android) {
  //   AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  // }
  WidgetsFlutterBinding.ensureInitialized();

  String? token = await getToken();
  String? userID = await getUserId();


  // final dio = Dio();
  // final dioClient = DioClient('https://sos.notionprojects.tech/', dio);

  runApp(const MyApp());
}

final dio = Dio();
final dioClient =
DioClient('https://ride.notionprojects.tech/api/customer/', dio);
class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
}
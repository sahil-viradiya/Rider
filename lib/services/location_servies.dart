import 'package:get/get.dart';
import 'package:rider/constant/api_key.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:rider/utils/app_logger.dart';

import '../../constant/app_image.dart';

class LocationServices {
  var status = ''.obs;
  RxDouble currerntLat = 0.0.obs;
  RxDouble currerntLng = 0.0.obs;
  Rx<Key> locationWidgetKey = UniqueKey().obs; // Key to rebuild the widget

 static  RxString currentLocation = ''.obs;

  LocationServices() {
    _initialize();
  }

  void _initialize() async {
    // Request permission for iOS
    // await _requestPermission();
   await getUserCurrentLocation();
    AppLogger.logger.f("location:-$currentLocation");
              rebuildLocationWidget();

  }

  getUserCurrentLocation() async {
    try {
      var status1 = await Permission.locationWhenInUse.request();

      if (status1.isGranted) {
        status.value = "Status.granted";
      } else {
        status.value = "Please Enable Location Services";
      }

      print("location:-$status");

      var accuracy = await Geolocator.getLocationAccuracy();
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();

      print("Permission ${PermissionStatus.granted}");

      if (status1 == PermissionStatus.granted) {
        if (isLocationServiceEnabled) {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          print("lat:-${position.latitude} lng:-${position.longitude}");
          currerntLat.value = position.latitude;
          currerntLng.value = position.longitude;
          rebuildLocationWidget();
          List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);
          log("current full location----> $placemarks");

          final apiKey = Config.apiKey; // Replace with your Google Maps API key
          final url =
              'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$apiKey';
          int retries = 3;
          for (int attempt = 1; attempt <= retries; attempt++) {
            try {
              final response = await http.get(Uri.parse(url));

              if (response.statusCode == 200) {
                final jsonResponse = jsonDecode(response.body);
                if (jsonResponse['status'] == 'OK') {
                  final results = jsonResponse['results'];
                  if (results.isNotEmpty) {
                    final address = results[0]['formatted_address'];
                    currentLocation.value = address;
                    // setState(() {
                    //   homeController.currentLocation.value = liveAddress.value;
                    // });
                    print('liveAddress:- ${currentLocation.value}');
                    return;
                  } else {
                    print('No addresses found');
                    Fluttertoast.showToast(
                        msg: "No address found for the provided coordinates");
                    return;
                  }
                } else {
                  print('Geocoding failed: ${jsonResponse['status']}');
                  Fluttertoast.showToast(
                      msg: "Geocoding failed: ${jsonResponse['status']}");
                }
              } else {
                print(
                    'HTTP request failed with status: ${response.statusCode}');
                Fluttertoast.showToast(
                    msg:
                        "HTTP request failed with status: ${response.statusCode}");
              }
              rebuildLocationWidget();
              print("currentLocation:-$currentLocation");
            } catch (e) {
              print(e.toString());
            }
          }
        } else {
          Fluttertoast.showToast(msg: "You need to allow location Service");
        }
      } else {
        Fluttertoast.showToast(
            msg: "You need to allow location permission in order to continue");
      }
    } catch (e) {
      debugPrint("getUserCurrentLocation:-$e");
    }
  }

  void rebuildLocationWidget() {
    locationWidgetKey.value = UniqueKey(); // Assign a new key to force rebuild
  }
}

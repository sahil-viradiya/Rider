import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart' as loc;
import 'package:maps_curved_line/maps_curved_line.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rider/constant/api_key.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/constant/const.dart';
import 'package:rider/main.dart';
import 'package:dio/dio.dart' as dio;

import 'package:rider/route/app_route.dart';

import 'package:rider/utils/network_client.dart';

class CustomerAddressController extends GetxController {
  final count = 0.obs;
  var selectedRadio = 0.obs;

  RxBool isLoading = false.obs;
  RxBool switchBtn = true.obs;
  RxString issueDes = 'Heavy Traffic Delivery Time Issue'.obs;
  TextEditingController issueDesdetails = TextEditingController();
  RxString delayDes = 'Stuck in Traffic'.obs;
  TextEditingController delayDesdetails = TextEditingController();

  final locationController = loc.Location();

  RxDouble currentLat = 0.0.obs;
  RxDouble currentLng = 0.0.obs;

  RxDouble pickupLat = 0.0.obs;
  RxDouble pickupLng = 0.0.obs;
  RxDouble dropLat = 0.0.obs;
  RxDouble dropLng = 0.0.obs;

  LatLng? currentPosition;
  Map<PolylineId, Polyline> polylines = {};
  RxList<Marker> markers = RxList<Marker>();

  Marker _movingMarker = Marker(
    markerId: const MarkerId("movingMarker"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
  );

  Timer? _animationTimer;
  int _animationIndex = 0;

  List<LatLng> destinations = [];

  @override
  void onReady() {
    var data = Get.arguments;
    if (data != null) {
      destinations.add(LatLng(data[2], data[3]));
      log("dest-----$destinations");

      update();
      currentLat.value = data[0];
      currentLng.value = data[1];
      dropLat.value = data[2];

      dropLng.value = data[3];
    }
    // getCurrentLocation();
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await initializeMap());
  }

  Future<void> initializeMap() async {
    // await fetchLocationUpdates();
    await fetchPolylinePoints();
    // startMarkerAnimation();
  }

  // Get current location
  Future getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return Future.error('Location services are disabled.');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      var location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      currentLat.value = location.latitude;
      currentLng.value = location.longitude;
      fetchLocationUpdates();

      update();
    } catch (error) {
      throw Exception("Get Current Location Exception:- $error");
    }
  }

  Future<void> fetchLocationUpdates() async {
    bool serviceEnabled;
    LocationPermission permissionGranted;

    serviceEnabled = await locationController.serviceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permissionGranted = await Geolocator.checkPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await Geolocator.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }

    locationController.onLocationChanged.listen((currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        currentPosition = LatLng(
          currentLocation.latitude!,
          currentLocation.longitude!,
        );
        currentLat.value = currentLocation.latitude!;
        currentLng.value = currentLocation.longitude!;

        fetchPolylinePoints();
      }
    });
  }

  Future<void> fetchPolylinePoints() async {
    final polylinePoints = PolylinePoints();

    for (int i = 0; i < destinations.length; i++) {
      final destination = destinations[i];
      final result = await polylinePoints.getRouteBetweenCoordinates(
        travelMode: TravelMode.driving,
        Config.apiKey!,
        PointLatLng(currentLat.value, currentLng.value),
        PointLatLng(dropLat.value, dropLng.value),
      );

      if (result.points.isNotEmpty) {
        updateMarkers(); // Update markers when location changes

        generatePolyLineFromPoints(result.points.map((point) {
          return LatLng(point.latitude, point.longitude);
        }).toList());
      } else {
        debugPrint(result.errorMessage);
      }
    }
  }

  Future<void> generatePolyLineFromPoints(
      List<LatLng> polylineCoordinates) async {
    const id = PolylineId('polyline');
    const id2 = PolylineId('polyline2');

    final polyline2 = Polyline(
      polylineId: id2,
      visible: true,
      width: 2,
      //latlng is List<LatLng>
      patterns: [PatternItem.dash(30), PatternItem.gap(10)],
      points: MapsCurvedLines.getPointsOnCurve(
          LatLng(currentLat.value, currentLng.value),
          LatLng(dropLat.value,
              dropLng.value)), // Invoke lib to get curved line points
      color: primary,
    );
    final polyline1 = Polyline(
      geodesic: true,
      consumeTapEvents: true,
      jointType: JointType.bevel,
      polylineId: id,

      // patterns: [PatternItem.],
      startCap: Cap.roundCap,
      endCap: Cap.squareCap,
      color: primary,
      points: polylineCoordinates,
      width: 2,
    );

    polylines[id] = polyline1;
    polylines[id2] = polyline2;

    refresh();
    update();
  }

  void updateMarkers() {
    markers.clear();
    markers.add(Marker(
      markerId: const MarkerId("source Location"),
      visible: true,
      infoWindow: const InfoWindow(title: "pickup Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      position: LatLng(currentLat.value, currentLng.value),
    ));
    markers.add(Marker(
      markerId: const MarkerId("destination Location"),
      infoWindow: const InfoWindow(title: "drop Location"),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(dropLat.value, dropLng.value),
    ));
  }

  void startMarkerAnimation() {
    if (polylines.isNotEmpty) {
      _animationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_animationIndex < polylines.values.first.points.length) {
          final nextPoint = polylines.values.first.points[_animationIndex];
          _movingMarker = _movingMarker.copyWith(
            positionParam: nextPoint,
          );
          markers.add(_movingMarker);
          update();
          _animationIndex++;
        } else {
          _animationTimer?.cancel();
        }
      });
    }
  }

  Future<dynamic> completeRide({required var id}) async {
    isLoading(true);
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'ride_id': id,
      });
      var response = await dioClient
          .post(
        '${Config.baseUrl}ride_completed.php',
        data: formData,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      )
          .then(
        (respo) async {
          // var respo = jsonDecode(respo);
          log("================================${respo['data']}===============");

          var message = respo['message'];
          try {
            if (respo['status'] == false) {
              DioExceptions.showErrorMessage(Get.context!, message);
              print('Message: $message');
            } else {
              DioExceptions.showMessage(Get.context!, message);
              Get.offAllNamed(AppRoutes.HOMESCREEN);
            }
          } catch (e) {
            print('Error parsing JSON or accessing message: $e');
          }
        },
      );
    } on dio.DioException catch (e) {
      print("status Code ${e.response?.statusCode}");
      print('Error $e');
      DioExceptions.showErrorMessage(
          Get.context!,
          DioExceptions.fromDioError(dioError: e, errorFrom: "start delivery")
              .errorMessage());
      isLoading(false);
    } catch (e) {
      isLoading(false);
      if (kDebugMode) {
        print("start delivery $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<dynamic> issueRide({required var id}) async {
    isLoading(true);
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'ride_id': id,
        'description': issueDesdetails.text + issueDes.value
      });
      var response = await dioClient
          .post(
        '${Config.baseUrl}issue_ride.php',
        data: formData,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      )
          .then(
        (respo) async {
          // var respo = jsonDecode(respo);
          log("================================${respo['data']}===============");

          var message = respo['message'];
          try {
            if (respo['status'] == false) {
              DioExceptions.showErrorMessage(Get.context!, message);
              print('Message: $message');
            } else {
              DioExceptions.showMessage(Get.context!, message);
              Get.offAllNamed(AppRoutes.HOMESCREEN);
            }
          } catch (e) {
            print('Error parsing JSON or accessing message: $e');
          }
        },
      );
    } on dio.DioException catch (e) {
      print("status Code ${e.response?.statusCode}");
      print('Error $e');
      DioExceptions.showErrorMessage(
          Get.context!,
          DioExceptions.fromDioError(dioError: e, errorFrom: "start delivery")
              .errorMessage());
      isLoading(false);
    } catch (e) {
      isLoading(false);
      if (kDebugMode) {
        print("start delivery $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<dynamic> delayRide({required var id}) async {
    isLoading(true);
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'ride_id': id,
        'description': issueDesdetails.text + issueDes.value
      });
      var response = await dioClient
          .post(
        '${Config.baseUrl}delay_ride.php',
        data: formData,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      )
          .then(
        (respo) async {
          // var respo = jsonDecode(respo);
          log("================================${respo['data']}===============");

          var message = respo['message'];
          try {
            if (respo['status'] == false) {
              DioExceptions.showErrorMessage(Get.context!, message);
              print('Message: $message');
            } else {
              DioExceptions.showMessage(Get.context!, message);
              Get.offAllNamed(AppRoutes.HOMESCREEN);
            }
          } catch (e) {
            print('Error parsing JSON or accessing message: $e');
          }
        },
      );
    } on dio.DioException catch (e) {
      print("status Code ${e.response?.statusCode}");
      print('Error $e');
      DioExceptions.showErrorMessage(
          Get.context!,
          DioExceptions.fromDioError(dioError: e, errorFrom: "start delivery")
              .errorMessage());
      isLoading(false);
    } catch (e) {
      isLoading(false);
      if (kDebugMode) {
        print("start delivery $e");
      }
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    _animationTimer?.cancel();
    super.onClose();
  }

  increment() => count.value++;
}

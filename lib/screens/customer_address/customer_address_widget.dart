import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/screens/customer_address/customer_address_controller.dart';
import 'package:rider/screens/home/home_screen.dart';
import 'package:rider/utils/app_logger.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;

class GoogleMapLocation extends StatelessWidget {
  const GoogleMapLocation({super.key});

  final Set<Marker> markers = const <Marker>{};

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CustomerAddressController());
    AppLogger.logger.i("Currnet Lat---> ${controller.currentLat.value}");
    AppLogger.logger.i("Currnet Lng---> ${controller.currentLng.value}");
    return WillPopScope(
      onWillPop: () {
        Get.offAll(() => const HomeScreen());
        return Future.value(true);
      },
      child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: FloatingActionButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            backgroundColor: primary,
            tooltip: "Go to Home",
            onPressed: () {
              Get.offAll(() => const HomeScreen());
            },
            child: const Icon(
              Icons.home,
              color: white,
            ),
          ),
          backgroundColor: white,
          body: Obx(
            () => controller.currentLat.value == 0.0
                ? const Center(
                    child: CircularProgressIndicator(
                    color: primary,
                  ))
                : GoogleMap(
                    // myLocationButtonEnabled: true,
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    rotateGesturesEnabled: true,
                    buildingsEnabled: true,
                    fortyFiveDegreeImageryEnabled: true,
                    mapToolbarEnabled: true,
                    // scrollGesturesEnabled: false,
                    // tiltGesturesEnabled: false,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,

                    initialCameraPosition: CameraPosition(
                      zoom: CAMERA_ZOOM,
                      // tilt: CAMERA_TILT,
                      bearing: CAMERA_BEARING,

                      target: LatLng(controller.currentLat.value,
                          controller.currentLng.value),
                    ),

                    polylines: Set<Polyline>.of(controller.polylines.values),
                    markers: Set<Marker>.of(controller.markers),
                  ),
          )),
    );
  }
}

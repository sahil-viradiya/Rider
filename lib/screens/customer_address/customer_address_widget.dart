import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:rider/constant/api_key.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/utils/app_logger.dart';

class CustomerAddressWidget extends StatefulWidget {
  const CustomerAddressWidget({super.key});

  @override
  _CustomerAddressWidgetState createState() => _CustomerAddressWidgetState();
}

RxDouble lat = 0.0.obs;
RxDouble lng = 0.0.obs;

class _CustomerAddressWidgetState extends State<CustomerAddressWidget> {
  final mapsWidgetController = GlobalKey<GoogleMapsWidgetState>();
  Set<Polyline> polylines = {}; // Initialize as an empty set
  StreamSubscription<Position>? positionSubscription;
  bool atPickupLocation = false; // State to track if driver is at pickup location

  LatLng pickupLocation = const LatLng(23.062757177531008, 72.55032365378294);
  LatLng dropLocation = const LatLng(23.027566175394984, 72.56068355193261);

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCurrentLocation();
      positionSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      ).listen((position) {
        lat.value = position.latitude;
        lng.value = position.longitude;
        updatePolylines();
        // checkIfReachedPickup();
      });
    });
  }

  Future<LatLng?> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return null;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      lat.value = position.latitude;
      lng.value = position.longitude;
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print("Error getting current location: $e");
      return null;
    }
  }

  void updatePolylines() {
    final driverLocation = LatLng(lat.value, lng.value);
    setState(() {
      polylines.clear();
      if (!atPickupLocation) {
        // Polyline from driver's current location to the pickup location
        polylines.add(
          Polyline(
            polylineId: const PolylineId("DriverToPickup"),
            // color: Colors.blue,

            points: [driverLocation, pickupLocation],
            width: 2,
          ),
        );
      } else {
        // Polyline from pickup location to the drop location
        // polylines.add(
        //   Polyline(
        //     polylineId: const PolylineId("PickupToDrop"),
        //     color: Colors.green,
        //     points: [pickupLocation, dropLocation],
        //     width: 2,
        //   ),
        // );
      }
    });
  }

  // void checkIfReachedPickup() {
  //   final distanceToPickup = Geolocator.distanceBetween(
  //     lat.value,
  //     lng.value,
  //     pickupLocation.latitude,
  //     pickupLocation.longitude,
  //   );

  //   if (distanceToPickup < 50) {
  //     // If the driver is within 50 meters of the pickup location
  //     setState(() {
  //       atPickupLocation = true;
  //     });
  //     print('Driver has reached the pickup location');
  //     // Optionally show a message or perform other actions
  //   }
  // }

  void checkIfReachedDrop() {
    final distanceToDrop = Geolocator.distanceBetween(
      lat.value,
      lng.value,
      dropLocation.latitude,
      dropLocation.longitude,
    );

    if (distanceToDrop < 50) {
      // If the driver is within 50 meters of the drop location
      print('Parcel delivered successfully');
      // Optionally show a message or perform other actions
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("ontime lat ${lat.value} === ${lng.value}");

    return Column(
      children: [
        Expanded(
          child: Obx(() =>lat.value==0.0?const CircularProgressIndicator(): GoogleMapsWidget(
                apiKey: Config.apiKey!,
                key: mapsWidgetController,
                // zoomControlsEnabled: true,
                // zoomGesturesEnabled: true,
                // myLocationEnabled: true,
                // myLocationButtonEnabled: true,

                sourceLatLng: const LatLng(23.025972438085866, 72.50690236113593),
                destinationLatLng: const LatLng(23.063722701049517, 72.55002591317422),
                routeWidth: 2,
                destinationMarkerIconInfo: MarkerIconInfo(
                  infoWindowTitle: "Pickup Location",
                  onTapInfoWindow: (_) {
                    print("Tapped on source info window");
                  },
                  assetPath: "assets/images/png/location-marker.png",
                ),
                // destinationMarkerIconInfo: const MarkerIconInfo(
                //   assetPath: "assets/images/png/location-marker.png",
                 
                // ),

                // defaultCameraLocation: LatLng(lat.value, lng.value),

                
                driverMarkerIconInfo: MarkerIconInfo(

                  infoWindowTitle: "Sahil",
                  // icon: const Icon(Icons.location_on, color: Colors.red, size: 35),
                  onTapMarker: (currentLocation) {
                    print("Driver is currently at $currentLocation");
                  },
                  assetMarkerSize: const Size.square(125),
                  rotation: 90,
                ),



                updatePolylinesOnDriverLocUpdate: true,


                routeColor: primary,


                onPolylineUpdate: (newPolylines) {
                  setState(() {
                    polylines.clear();
                    polylines.add(newPolylines);
                  });
                  print("Polyline updated");
                },

                // polylines: polylines,



                driverCoordinatesStream:
                    Stream.periodic(const Duration(milliseconds: 500), (i) {
                  final driverLat = lat.value;
                  final driverLng = lng.value;
                  final driverLocation = LatLng(driverLat, driverLng);
                  updatePolylines();
                  if (atPickupLocation) {
                    checkIfReachedDrop();
                  }
                  return driverLocation;
                }),

                //  driverCoordinatesStream: Stream.periodic(
                  //   const Duration(milliseconds: 500),
                  //   (i) {
                  //     return LatLng(
                  //   //  lat.value + i / 10000,
                  //   //   lng.value - i / 10000,
                  //   );
                  //   },
                  // ),


                totalTimeCallback: (time) => AppLogger.logger.i("==========times=============$time"),
                totalDistanceCallback: (distance) => AppLogger.logger.e("==========distance=============$distance"),
              )),
        ),
      ],
    );
  }

  @override
  void dispose() {
    positionSubscription?.cancel();
    super.dispose();
  }
}

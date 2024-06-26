import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:rider/constant/api_key.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/constant/app_image.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as location;

import 'package:rider/constant/style.dart';
import 'package:rider/route/app_route.dart';
import 'package:rider/screens/customer_address/customer_address_controller.dart';
import 'package:rider/screens/orders/orders_controller.dart';
import 'package:rider/widget/app_text_field.dart';
import 'package:rider/widget/auth_app_bar_widget.dart';
import 'package:rider/widget/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

const double CAMERA_ZOOM = 16;

class CustomerAddressWidget extends StatefulWidget {
  const CustomerAddressWidget(
      {super.key, required this.pickUpLat, required this.pickUpLng});

  final double pickUpLat;
  final double pickUpLng;

  @override
  State<CustomerAddressWidget> createState() => _CustomerAddressWidgetState();
}

class _CustomerAddressWidgetState extends State<CustomerAddressWidget> {
  Completer<GoogleMapController> mapController = Completer();

  var markers = <Marker>{}.obs;
  double? lat, lng;
  RxDouble updateLat = 0.0.obs, updateLng = 0.0.obs;
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  String address = '';
  String cityName = '';
  var _controller = CustomerAddressController();
  late LatLng dropLocation;
  location.LocationData? currentLocation;
  LatLng? pickupLocation;
  var icon;
  OrdersController _ordersController = Get.put(OrdersController());

  @override
  void initState() {
    super.initState();
    startProcess();
  }
  @override
  void dispose() {
    stopListeningToLocation();
    super.dispose();
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
    } else {
      getUserCurrentLocation();
    }
  }

  void _showLocationServicesDialog() {
    showDialog(
      context: context,
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
      context: context,
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
  void stopListeningToLocation() {
    if (locationSubscription != null) {
      locationSubscription!.cancel();
      locationSubscription = null;
    }}

  location.LocationData? currentLoc;
  StreamSubscription<location.LocationData>? locationSubscription;

  Set<Polyline> polylines = {};

  void getUserCurrentLocation() async {
    location.Location fetchLocation = location.Location();

    var status = await Permission.location.request();
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (status == PermissionStatus.granted) {
      if (isLocationServiceEnabled) {
        await Geolocator.getCurrentPosition().then((value) async {
          final GoogleMapController controller = await mapController.future;

          locationSubscription =  fetchLocation.onLocationChanged
              .listen((location.LocationData newLoc) {
            log("new LOCCCCC ${newLoc}");
            currentLocation = newLoc;
            updateLat.value = newLoc.latitude!;
            updateLng.value = newLoc.longitude!;
            pickupLocation = LatLng(newLoc.latitude!, newLoc.longitude!);
            address = address;
            dropLocation = LatLng(widget.pickUpLat, widget.pickUpLng);
            getIcons();

          });

          setState(() {
            lat = updateLat.value;
            lng = updateLng.value;
          });

        });

      } else {
        Fluttertoast.showToast(msg: "You need to allow location Service");
      }
    } else {
      Fluttertoast.showToast(
          msg: "You need to allow location permission in order to continue");
    }
  }

  getIcons() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 3),
        "assets/images/png/location-marker.png");
    setState(() {
      this.icon = icon;
    });
    setMarkersAndPolyline();
  }

  void setMarkersAndPolyline() async {
    markers.value.add(Marker(
      markerId: const MarkerId('pickup'),
      position: pickupLocation!,
      infoWindow: const InfoWindow(title: 'Pickup Location'),
    ));
    markers.value.add(Marker(
      markerId: const MarkerId('drop'),
      icon: icon,
      position: dropLocation,
      infoWindow: const InfoWindow(title: 'Drop Location'),
    ));

    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${pickupLocation!.latitude},${pickupLocation!.longitude}&destination=${dropLocation.latitude},${dropLocation.longitude}&key=${Config.apiKey}";
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = jsonDecode(response.body);

    if (data['status'] == 'OK') {
      List<LatLng> polylineCoordinates =
          decodePolyline(data['routes'][0]['overview_polyline']['points']);

      polylines.add(Polyline(
        polylineId: const PolylineId('route'),
        points: polylineCoordinates,
        startCap: Cap.buttCap,
        color: primary,
        jointType: JointType.round,
        patterns: [PatternItem.dot, PatternItem.gap(10)],
        width: 5,
      ));

      // Adjust the camera position to fit the polyline
      final GoogleMapController controller = await mapController.future;
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          (pickupLocation!.latitude < dropLocation.latitude)
              ? pickupLocation!.latitude
              : dropLocation.latitude,
          (pickupLocation!.longitude < dropLocation.longitude)
              ? pickupLocation!.longitude
              : dropLocation.longitude,
        ),
        northeast: LatLng(
          (pickupLocation!.latitude > dropLocation.latitude)
              ? pickupLocation!.latitude
              : dropLocation.latitude,
          (pickupLocation!.longitude > dropLocation.longitude)
              ? pickupLocation!.longitude
              : dropLocation.longitude,
        ),
      );
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    } else {
      Fluttertoast.showToast(msg: "Failed to get route");
    }

    setState(() {});
  }

  List<LatLng> decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0, len = polyline.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble()));
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      appBar: appbarSmall1(
        context,
        "Set Drop Location",
      ),
      key: homeScaffoldKey,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Obx(
            () => GoogleMap(
              onMapCreated: onMapCreated,
              mapToolbarEnabled: true,
              padding: const EdgeInsets.only(
                bottom: 80,
              ),
              mapType: MapType.normal,
              buildingsEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              initialCameraPosition:
                  const CameraPosition(target: LatLng(0.0, 0.0), zoom: 17),
              markers: markers.value,
              polylines: polylines,
              onTap: (LatLng pos) {
                setState(() {
                  lat = pos.latitude;
                  lng = pos.longitude;
                  // markers.add(Marker(
                  //     markerId: const MarkerId("newLocation"), position: pos));
                });
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            // height: 120,

            decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  spreadRadius: 4,
                  color: Colors.black12,
                )
              ],
            ),
            child: CustomButton(
              width: Get.width,
              height: 35,
              borderCircular: 6,
              text: "Start Delivery",
              fun: currentLocation?.latitude == null
                  ? () {}
                  : () {
                      _showStartDeliveryDialog(context);
                    },
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 60, right: 10),
              child: SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: primary,
                    textStyle: const TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  onPressed: getUserCurrentLocation,
                  child: const Icon(Icons.my_location_rounded,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController.complete(controller);
    });
  }

  void _showStartDeliveryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // contentPadding: EdgeInsets.all(0),
          insetPadding: const EdgeInsets.all(8),
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          // title: const Text("Start Delivery"),
          content: Container(
            decoration: BoxDecoration(
                border: Border.all(color: primary),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Gap(10),
                SvgPicture.asset(AppImage.INFO_BIG),
                const Gap(14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting",
                    style: Styles.lable414,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      height: 32,
                      width: 100,
                      borderCircular: 6,
                      text: "Confirm",
                      style: Styles.boldwhite712,
                      fun: () {
                        // _controller.sta
                        Navigator.of(context).pop(); // Close the dialog
                        _showBottomSheet(context); // Show the bottom sheet
                      },
                    ),
                    const Gap(12),
                    CustomButton(
                      height: 32,
                      width: 100,
                      color: const Color(0xFFE5E5E5),
                      borderCircular: 6,
                      text: "Cancle",
                      style: Styles.boldBlack712,
                      fun: () {},
                    ),
                  ],
                ),
                const Gap(12)
              ],
            ),
          ),
        );
      },
    );
  }

  void _launchMaps() async {
    // Assuming locations contains at least two points: start and destination
    if (currentLocation!.latitude != null) {
      // URL scheme for Google Maps
      String googleMapsUrl =
          "https://www.google.com/maps/dir/?api=1&origin=${currentLocation!.latitude!},${currentLocation!.longitude!}&destination=${widget.pickUpLat},${widget.pickUpLng}";

      if (await canLaunch(googleMapsUrl)) {
        await launch(googleMapsUrl);
      } else {
        throw 'Could not launch $googleMapsUrl';
      }
    } else {
      // Handle error for insufficient locations
      Get.snackbar("Error", "Insufficient locations provided");
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                color: primary,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Text(
                        "Order ID",
                        style: Styles.boldBlack612,
                      ),
                      const Gap(14),
                      Text(
                        _ordersController
                            .customerAddressController.startRideModel.orderID
                            .toString(),
                        style: Styles.lable414,
                      ),
                      const Spacer(),
                      SvgPicture.asset(AppImage.PHONE),
                      const Gap(12),
                      SvgPicture.asset(
                        AppImage.LOCATION,
                        width: 16,
                        height: 16,
                        color: primary,
                      )
                    ],
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Text(
                        "Customer Name",
                        style: Styles.boldBlack612,
                      ),
                      const Gap(14),
                      Text(
                        _ordersController.customerAddressController
                            .startRideModel.customerName
                            .toString(),
                        style: Styles.lable414,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Time",
                        style: Styles.boldBlack614,
                      ),
                      const Gap(6),
                      Text(
                        _ordersController.customerAddressController
                            .startRideModel.deliveryTime
                            .toString(),
                        style: Styles.lable414,
                      ),
                      // const Gap(4),
                      // Text(
                      //   "04:00 PM to 04:30 PM",
                      //   style: Styles.lable414,
                      // ),
                    ],
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    _launchMaps();
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        child: Text(
                          "Delivery Address",
                          style: Styles.boldBlack614,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 1),
                        child: Text(
                          _ordersController.customerAddressController
                              .startRideModel.deliveryAddress
                              .toString(),
                          style: Styles.lable414,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(8),
                    Expanded(
                      child: CustomButton(
                        height: 32,
                        // width: 100,
                        borderCircular: 6,
                        text: "Delivered",
                        style: Styles.boldwhite712,
                        fun: () {
                          Navigator.of(context).pop(); // Close the dialog
                          _deliver(context);
                        },
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: CustomButton(
                        height: 32,
                        // width: 100,
                        borderCircular: 6,
                        text: "Issue",
                        style: Styles.boldwhite712,
                        fun: () {
                          Navigator.of(context).pop(); // Close the dialog
                          _issue(context);
                        },
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: CustomButton(
                        height: 32,
                        // width: 100,
                        borderCircular: 6,
                        text: "Delay",
                        style: Styles.boldwhite712,
                        fun: () {
                          Navigator.of(context).pop();
                          _delay(context); // Close the dialog
                        },
                      ),
                    ),
                    const Gap(8),
                  ],
                ),
                const Gap(8),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deliver(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // contentPadding: EdgeInsets.all(0),
          insetPadding: const EdgeInsets.all(8),
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          // title: const Text("Start Delivery"),
          content: Container(
            decoration: BoxDecoration(
                border: Border.all(color: primary),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Gap(10),
                SvgPicture.asset(AppImage.INFO_BIG),
                const Gap(14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Are you Sure you want to mark this Order as Delivered?",
                    style: Styles.lable414,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      height: 32,
                      width: 100,
                      borderCircular: 6,
                      text: "Confirm",
                      style: Styles.boldwhite712,
                      fun: () {
                        Navigator.of(context).pop();
                        stopListeningToLocation();
                        _controller.completeRide(id:  _ordersController
                            .customerAddressController.startRideModel.orderID
                            .toString(),);// Close the dialog
                      },
                    ),
                    const Gap(12),
                    CustomButton(
                      height: 32,
                      width: 100,
                      color: const Color(0xFFE5E5E5),
                      borderCircular: 6,
                      text: "Cancle",
                      style: Styles.boldBlack712,
                      fun: () {},
                    ),
                  ],
                ),
                const Gap(12)
              ],
            ),
          ),
        );
      },
    );
  }

  void _issue(BuildContext context) {
    final titles = [
      'Heavy Traffic Delivery Time Issue',
      'Address Not Found',
      'Customer Door Closed',
      'Customer Not Accepting the Order',
      'Customer Blames He Didn’t Place an Order',
      'Other'
    ];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // contentPadding: EdgeInsets.all(0),
          insetPadding: const EdgeInsets.all(8),
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          // title: const Text("Start Delivery"),
          content: Container(
            decoration: BoxDecoration(
                border: Border.all(color: primary),
                borderRadius: BorderRadius.circular(7)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List<Widget>.generate(6, (int index) {
                      return Obx(() => RadioListTile<int>(
                            activeColor: primary,
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Text(
                              titles[index],
                              style: Styles.lable414,
                            ),
                            value: index,
                            groupValue: _controller.selectedRadio.value,
                            onChanged: (int? value) {
                              _controller.selectedRadio.value = value!;
                              _controller.issueDes.value = titles[index];
                              log("issue des ${titles[index]}");
                            },
                          ));
                    }),
                  ),
                  const Gap(8),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text(
                        "Description",
                        style: Styles.boldBlack612,
                      ),
                    ),
                  ),
                  const Gap(8),
                   Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: CustomTextFormFieldWidget(
                      controller: _controller.issueDesdetails,
                      hintTpadding: 25,
                      minLine: 5,
                      maxLine: 5,
                    ),
                  ),
                  const Divider(),
                  const Gap(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        height: 32,
                        width: 100,
                        borderCircular: 6,
                        text: "Confirm",
                        style: Styles.boldwhite712,
                        fun: () {
                          _controller.issueRide(id:  _ordersController
                              .customerAddressController.startRideModel.orderID
                              .toString(),
                          );
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      const Gap(12),
                      CustomButton(
                        height: 32,
                        width: 100,
                        color: const Color(0xFFE5E5E5),
                        borderCircular: 6,
                        text: "Back",
                        style: Styles.boldBlack712,
                        fun: () {
                          Navigator.of(context).pop(); // Close the dialog

                        },
                      ),
                    ],
                  ),
                  const Gap(12)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _delay(BuildContext context) {
    final titles = [
      'Stuck in Traffic',
      'Road Closed Divert New Route',
      'New Delivery Address Diverted By Customer',
      'Other',
    ];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // contentPadding: EdgeInsets.all(0),
          insetPadding: const EdgeInsets.all(8),
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          // title: const Text("Start Delivery"),
          content: Container(
            decoration: BoxDecoration(
                border: Border.all(color: primary),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List<Widget>.generate(4, (int index) {
                    return Obx(() => RadioListTile<int>(
                          activeColor: primary,
                          controlAffinity: ListTileControlAffinity.trailing,
                          title: Text(
                            titles[index],
                            style: Styles.lable414,
                          ),
                          value: index,
                          groupValue: _controller.selectedRadio.value,
                          onChanged: (int? value) {
                            _controller.selectedRadio.value = value!;
                            _controller.delayDes.value=titles[index];
                          },
                        ));
                  }),
                ),
                const Gap(8),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      "Description",
                      style: Styles.boldBlack612,
                    ),
                  ),
                ),
                const Gap(8),
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                  child: CustomTextFormFieldWidget(
                    hintTpadding: 25,
                    controller: _controller.delayDesdetails,
                    minLine: 5,
                    maxLine: 5,
                  ),
                ),
                const Divider(),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      height: 32,
                      width: 100,
                      borderCircular: 6,
                      text: "Confirm",
                      style: Styles.boldwhite712,
                      fun: () {
                        _controller.issueRide(id:  _ordersController
                            .customerAddressController.startRideModel.orderID
                            .toString(),
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                    const Gap(12),
                    CustomButton(
                      height: 32,
                      width: 100,
                      color: const Color(0xFFE5E5E5),
                      borderCircular: 6,
                      text: "Back",
                      style: Styles.boldBlack712,
                      fun: () {
                        Navigator.of(context).pop();

                      },
                    ),
                  ],
                ),
                const Gap(12)
              ],
            ),
          ),
        );
      },
    );
  }
}

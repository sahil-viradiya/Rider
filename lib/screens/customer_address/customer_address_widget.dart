import 'dart:async';
import 'dart:convert';
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

import 'package:rider/constant/style.dart';
import 'package:rider/screens/customer_address/customer_address_controller.dart';
import 'package:rider/widget/app_text_field.dart';
import 'package:rider/widget/auth_app_bar_widget.dart';
import 'package:rider/widget/custom_button.dart';

class CustomerAddressWidget extends StatefulWidget {
  const CustomerAddressWidget({super.key});

  @override
  State<CustomerAddressWidget> createState() => _CustomerAddressWidgetState();
}

class _CustomerAddressWidgetState extends State<CustomerAddressWidget> {
  Completer<GoogleMapController> mapController = Completer();

  Set<Marker> markers = {};
  double? lat, lng;
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  String address = '';
  String cityName = '';
  var _controller = CustomerAddressController();
  late LatLng dropLocation;
  late LatLng pickupLocation;
  var icon;

  @override
  void initState() {
    super.initState();
    startProcess();
  }

  startProcess()async{
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

  void getUserCurrentLocation() async {
    var status = await Permission.location.request();
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (status == PermissionStatus.granted) {
      if (isLocationServiceEnabled) {
        await Geolocator.getCurrentPosition().then((value) async {
          final GoogleMapController controller = await mapController.future;
          setState(() {
            controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(value.latitude, value.longitude),
                    zoom: 17)));
            markers.add(Marker(
                markerId: const MarkerId("newLocation"),
                position: LatLng(value.latitude, value.longitude)));
            address = address;
            pickupLocation = LatLng(value.latitude, value.longitude);
            dropLocation =  LatLng(_controller.dropLat.value,_controller.dropLng.value);
            getIcons();
            lat = value.latitude;
            lng = value.longitude;
          });
          await getAddress();
        });
      } else {
        Fluttertoast.showToast(msg: "You need to allow location Service");
      }
    } else {
      Fluttertoast.showToast(
          msg: "You need to allow location permission in order to continue");
    }
  }

  Set<Polyline> polylines = {};

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
    markers.add(Marker(
      markerId: const MarkerId('pickup'),
      position: dropLocation,
      icon: icon,
      infoWindow: const InfoWindow(title: 'Pickup Location'),
    ));
    markers.add(Marker(
      markerId: const MarkerId('drop'),
      icon: icon,
      position: pickupLocation,
      infoWindow: const InfoWindow(title: 'Drop Location'),
    ));

    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${pickupLocation.latitude},${pickupLocation.longitude}&destination=${dropLocation.latitude},${dropLocation.longitude}&key=${Config.apiKey}";
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
          (pickupLocation.latitude < dropLocation.latitude)
              ? pickupLocation.latitude
              : dropLocation.latitude,
          (pickupLocation.longitude < dropLocation.longitude)
              ? pickupLocation.longitude
              : dropLocation.longitude,
        ),
        northeast: LatLng(
          (pickupLocation.latitude > dropLocation.latitude)
              ? pickupLocation.latitude
              : dropLocation.latitude,
          (pickupLocation.longitude > dropLocation.longitude)
              ? pickupLocation.longitude
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
      backgroundColor: white,
      appBar: appbarSmall1(
        context,
        "Set Drop Location",
      ),
      key: homeScaffoldKey,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            compassEnabled: false,
            mapToolbarEnabled: false,
            onMapCreated: onMapCreated,
            initialCameraPosition:
                const CameraPosition(target: LatLng(0.0, 0.0), zoom: 17),
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: markers,
            polylines: polylines,
            onTap: (LatLng pos) {
              setState(() {
                lat = pos.latitude;
                lng = pos.longitude;
                markers.add(Marker(
                    markerId: const MarkerId("newLocation"), position: pos));
              });
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            // height: 120,

            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
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
              fun: () {
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

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: Config.apiKey!,
      onError: onError,
      mode: Mode.overlay,
      language: "en-us",
      types: [""],
      strictbounds: false,
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [
        Component(Component.country, "pk"),
        Component(Component.country, "in")
      ],
    );
    displayPrediction(p!, homeScaffoldKey.currentState!);
  }

  Future<void> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: Config.apiKey!,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail =
        await places.getDetailsByPlaceId(p.placeId.toString());
    lat = detail.result.geometry!.location.lat;
    lng = detail.result.geometry!.location.lng;
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat!, lng!), zoom: 17)));
    setState(() {
      markers.add(Marker(
          markerId: const MarkerId("newLocation"),
          position: LatLng(lat!, lng!)));
    });
    await getAddress();
  }

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMessage.toString())),
    );
  }

  getAddress() async {
    GeoData fetchGeocoder = await Geocoder2.getDataFromCoordinates(
        latitude: lat!, longitude: lng!, googleMapApiKey: Config.apiKey!);
    setState(() {
      address = fetchGeocoder.address;
      cityName = extractCity(fetchGeocoder.address);
      print("==========add========${fetchGeocoder.address}");
    });
    // Get.back(result: [fetchGeocoder.address]);
    // Get.back(result: [fetchGeocoder.address, lat.toString(), lng.toString()]);
  }

  String extractCity(String fullAddress) {
    List<String> addressParts = fullAddress.split(',');
    if (addressParts.length >= 2) {
      return addressParts[addressParts.length - 3].trim();
    }
    return "Unknown";
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
                        "9872589963188985",
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
                        "John",
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
                        "Mon, 26 Feb 2024",
                        style: Styles.lable414,
                      ),
                      const Gap(4),
                      Text(
                        "04:00 PM to 04:30 PM",
                        style: Styles.lable414,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Text(
                    "Delivery Address",
                    style: Styles.boldBlack614,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 1),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy",
                    style: Styles.lable414,
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
                        Navigator.of(context).pop(); // Close the dialog
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                  child: CustomTextFormFieldWidget(
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                  child: CustomTextFormFieldWidget(
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
}

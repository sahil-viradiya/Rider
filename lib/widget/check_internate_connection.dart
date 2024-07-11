import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rider/main.dart';

class MyConnectivity {
  MyConnectivity._();

  static final _instance = MyConnectivity._();
  static MyConnectivity get instance => _instance;
  final Connectivity _connectivity = Connectivity();
  final StreamController<Map<ConnectivityResult, bool>> _controller =
      StreamController<Map<ConnectivityResult, bool>>.broadcast();
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  Stream<Map<ConnectivityResult, bool>> get myStream => _controller.stream;

  Future<void> initialise() async {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    await _updateConnectionStatus(await _connectivity.checkConnectivity());
    MyConnectivity.instance.myStream.listen((event) {
      event.forEach((result, isOnline) {
        print('ConnectivityResult123: $result, isOnline: $isOnline');
        // setState(() {
          isOn.value = isOnline;
        // });
      });
    });
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus = result;
    await _checkStatus(_connectionStatus[0]);
    // ignore: avoid_print

    print('Connectivity changed: ${_connectionStatus[0]}');
  }

  Future<void> _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final lookupResult = await InternetAddress.lookup('example.com');
      isOnline = lookupResult.isNotEmpty && lookupResult[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() {
    _connectivitySubscription.cancel();
    _controller.close();
  }
}

// device_info_service.dart
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class DeviceInfoService {
  Future<String> getDeviceType(BuildContext context) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceType;

    if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceType = 'iOS';
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceType = 'Android';
    } else if (Theme.of(context).platform == TargetPlatform.windows) {
      WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
      deviceType = 'Windows';
    } else if (Theme.of(context).platform == TargetPlatform.linux) {
      LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
      deviceType = 'Linux';
    } else if (Theme.of(context).platform == TargetPlatform.macOS) {
      MacOsDeviceInfo macosInfo = await deviceInfo.macOsInfo;
      deviceType = 'macOS';
    } else {
      deviceType = 'Unknown';
    }

    return deviceType;
  }
}

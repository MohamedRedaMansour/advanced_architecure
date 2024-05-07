import 'dart:io';

import 'package:path_provider/path_provider.dart' as path;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../features/model/device_info_model.dart';

class DeviceInfoDetails {
  static DeviceInfoDetails? _instance;

  DeviceInfoDetails._internal();

  factory DeviceInfoDetails() {
    return _instance ??= DeviceInfoDetails._internal();
  }

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  DeviceInfo? deviceData;
  PackageInfo? packageInfo;
  Directory? securePath;
  Directory? publicPath;
  String? identifier;
  String?  appVersion;
  Future<void> initPlatformState() async {
    packageInfo = await PackageInfo.fromPlatform();
    securePath = await path.getApplicationDocumentsDirectory();
    publicPath = await path.getTemporaryDirectory();

    try {
      if (Platform.isAndroid) {

        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
      appVersion ??= deviceData?.appVersion;
    } on PlatformException {
      deviceData = DeviceInfo.fromJson(
          <String, dynamic>{"error": "Failed to get platform version."});
    }
  }

  DeviceInfo _readAndroidBuildData(AndroidDeviceInfo build) {
    return DeviceInfo.fromJson(<String, dynamic>{
      "version": {
        "securityPatch": build.version.securityPatch,
        "securityPatch": build.version.securityPatch,
        "sdkInt": build.version.sdkInt,
        "release": build.version.release,
        "previewSdkInt": build.version.previewSdkInt,
        "incremental": build.version.incremental,
        "codename": build.version.codename,
        "baseOS": build.version.baseOS,
      },
      "board": build.board,
      "bootloader": build.bootloader,
      "brand": build.brand,
      "device": build.device,
      "display": build.display,
      "fingerprint": build.fingerprint,
      "hardware": build.hardware,
      "host": build.host,
      "id": build.id,
      "manufacturer": build.manufacturer,
      "model": build.model,
      "product": build.product,
      "supported32BitAbis": build.supported32BitAbis,
      "supported64BitAbis": build.supported64BitAbis,
      "supportedAbis": build.supportedAbis,
      "tags": build.tags,
      "type": build.type,
      "isPhysicalDevice": build.isPhysicalDevice,
      "androidId": build.id,
      "systemFeatures": build.systemFeatures,
      "operatingSystem": "Android",
      "appName": packageInfo?.appName,
      "packageName": packageInfo?.packageName,
      "appVersion": packageInfo?.version,
      "buildNumber": packageInfo?.buildNumber
    });
  }

  DeviceInfo _readIosDeviceInfo(IosDeviceInfo data) {
    return DeviceInfo.fromJson(<String, dynamic>{
      "name": data.name,
      "systemName": data.systemName,
      "systemVersion": data.systemVersion,
      "model": data.model,
      "localizedModel": data.localizedModel,
      "identifierForVendor": data.identifierForVendor,
      "isPhysicalDevice": data.isPhysicalDevice,
      "utsname": {
        "sysname:": data.utsname.sysname,
        "nodename:": data.utsname.nodename,
        "release:": data.utsname.release,
        "version:": data.utsname.version,
        "machine:": data.utsname.machine,
      },
      "operatingSystem": "IOS",
      "appName": packageInfo?.appName,
      "packageName": packageInfo?.packageName,
      "appVersion": packageInfo?.version,
      "buildNumber": packageInfo?.buildNumber
    });
  }
}

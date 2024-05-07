import 'dart:convert';

DeviceInfo deviceInfoFromJson(String str) => DeviceInfo.fromJson(json.decode(str));

String deviceInfoToJson(DeviceInfo data) => json.encode(data.toJson());

class DeviceInfo {
  DeviceInfo({
    this.version,
    this.board,
    this.bootloader,
    this.brand,
    this.device,
    this.display,
    this.fingerprint,
    this.hardware,
    this.host,
    this.id,
    this.manufacturer,
    this.model,
    this.product,
    this.supported32BitAbis,
    this.supported64BitAbis,
    this.supportedAbis,
    this.tags,
    this.type,
    this.isPhysicalDevice,
    this.androidId,
    this.systemFeatures,
    this.operatingSystem,
    this.appName,
    this.packageName,
    this.appVersion,
    this.buildNumber,
    this.name,
    this.systemName,
    this.systemVersion,
    this.localizedModel,
    this.identifierForVendor,
    this.utsname,
    this.error,
  });

  Version? version;
  String? board;
  String? bootloader;
  String? brand;
  String? device;
  String? display;
  String? fingerprint;
  String? hardware;
  String? host;
  String? id;
  String? manufacturer;
  String? model;
  String? product;
  var supported32BitAbis;
  var supported64BitAbis;
  var supportedAbis;
  String? tags;
  String? type;
  bool? isPhysicalDevice;
  String? androidId;
  var systemFeatures;
  String? operatingSystem;
  String? appName;
  String? packageName;
  String? appVersion;
  String? buildNumber;
  String? name;
  String? systemName;
  String? systemVersion;
  String? localizedModel;
  String? identifierForVendor;
  Utsname? utsname;
  String? error;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) => DeviceInfo(
    version: json["version"] !=null?Version.fromJson(json["version"]):null,
    board: json["board"],
    bootloader: json["bootloader"],
    brand: json["brand"],
    device: json["device"],
    display: json["display"],
    fingerprint: json["fingerprint"],
    hardware: json["hardware"],
    host: json["host"],
    id: json["id"],
    manufacturer: json["manufacturer"],
    model: json["model"],
    product: json["product"],
    supported32BitAbis: json["supported32BitAbis"],
    supported64BitAbis: json["supported64BitAbis"],
    supportedAbis: json["supportedAbis"],
    tags: json["tags"],
    type: json["type"],
    isPhysicalDevice: json["isPhysicalDevice"],
    androidId: json["androidId"],
    systemFeatures: json["systemFeatures"],
    operatingSystem: json["operatingSystem"],
    appName: json["appName"],
    packageName: json["packageName"],
    appVersion: json["appVersion"],
    buildNumber: json["buildNumber"],
    name: json["name"],
    systemName: json["systemName"],
    systemVersion: json["systemVersion"],
    localizedModel: json["localizedModel"],
    identifierForVendor: json["identifierForVendor"],
    utsname: json["utsname"]!=null?Utsname.fromJson(json["utsname"]):null,
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "version": version!=null?version!.toJson():null,
    "board": board,
    "bootloader": bootloader,
    "brand": brand,
    "device": device,
    "display": display,
    "fingerprint": fingerprint,
    "hardware": hardware,
    "host": host,
    "id": id,
    "manufacturer": manufacturer,
    "model": model,
    "product": product,
    "supported32BitAbis": supported32BitAbis,
    "supported64BitAbis": supported64BitAbis,
    "supportedAbis": supportedAbis,
    "tags": tags,
    "type": type,
    "isPhysicalDevice": isPhysicalDevice,
    "androidId": androidId,
    "systemFeatures": systemFeatures,
    "operatingSystem": operatingSystem,
    "appName": appName,
    "packageName": packageName,
    "appVersion": appVersion,
    "buildNumber": buildNumber,
    "name": name,
    "systemName": systemName,
    "systemVersion": systemVersion,
    "localizedModel": localizedModel,
    "identifierForVendor": identifierForVendor,
    "utsname": utsname!=null?utsname!.toJson():null,
    "error": error,
  };
}

class Utsname {
  Utsname({
    this.sysname,
    this.nodename,
    this.release,
    this.version,
    this.machine,
  });

  String? sysname;
  String? nodename;
  String? release;
  String? version;
  String? machine;

  factory Utsname.fromJson(Map<String, dynamic> json) => Utsname(
    sysname: json["sysname:"],
    nodename: json["nodename:"],
    release: json["release:"],
    version: json["version:"],
    machine: json["machine:"],
  );

  Map<String, dynamic> toJson() => {
    "sysname:": sysname,
    "nodename:": nodename,
    "release:": release,
    "version:": version,
    "machine:": machine,
  };
}

class Version {
  Version({
    this.securityPatch,
    this.sdkInt,
    this.release,
    this.previewSdkInt,
    this.incremental,
    this.codename,
    this.baseOs,
  });

  String? securityPatch;
  int? sdkInt;
  String? release;
  int? previewSdkInt;
  String? incremental;
  String? codename;
  String? baseOs;

  factory Version.fromJson(Map<String, dynamic> json) => Version(
    securityPatch: json["securityPatch"],
    sdkInt: json["sdkInt"],
    release: json["release"],
    previewSdkInt: json["previewSdkInt"],
    incremental: json["incremental"],
    codename: json["codename"],
    baseOs: json["baseOS"],
  );

  Map<String, dynamic> toJson() => {
    "securityPatch": securityPatch,
    "sdkInt": sdkInt,
    "release": release,
    "previewSdkInt": previewSdkInt,
    "incremental": incremental,
    "codename": codename,
    "baseOS": baseOs,
  };
}

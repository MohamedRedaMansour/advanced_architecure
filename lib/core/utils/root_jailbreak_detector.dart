import 'dart:io' show Platform;

import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

class RootJailBreakDetector {
  /// Returns true if device is rooted
  ///
  /// in case of rooted android devices [RootedState] is emitted
  static Future<bool> isDeviceRooted() async {
    if (Platform.isAndroid) {
      final bool isRooted = await FlutterJailbreakDetection.jailbroken;
      return isRooted;
    } else {
      return false;
    }
  }

  /// Returns true if device is jailBroken
  ///
  /// in case of jailBroken iOS devices [JailBrokenState] is emitted
  static Future<bool> isDeviceJailBroken() async {
    if (Platform.isIOS) {
      final bool isJailBroken = await FlutterJailbreakDetection.jailbroken;
      return isJailBroken;
    } else {
      return false;
    }
  }
}

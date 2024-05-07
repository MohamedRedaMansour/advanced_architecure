import 'package:flutter/cupertino.dart';

class Navigation {
  static Navigation? singleton;
  static dynamic navigationKey;
  factory Navigation({required GlobalKey navigatorKey}) {
    navigationKey = navigatorKey;
    singleton = singleton ?? Navigation._internal();
    return singleton!;
  }

  Navigation._internal();

  Future<dynamic> navigateTo({required String routeName,Object? arg}) {
    return navigationKey.currentState?.pushNamed(routeName,arguments:arg);
  }

  Future<dynamic> navigateAndReplacement({required String routeName,Object? arg}) {
    return navigationKey.currentState?.pushReplacementNamed(routeName,arguments:arg);
  }

  navigateAndPopUntil({required bool beCleared}) {
    return navigationKey.currentState?.popUntil((_) => beCleared);
  }

  Future<dynamic> navigateAndRemoveUntil(
      {required String routeName, bool beCleared= false,Object? arg}) {
    return navigationKey.currentState?.pushNamedAndRemoveUntil(routeName, (_) => beCleared,arguments:arg);
  }

  goBack({dynamic argument}) {
    return navigationKey.currentState?.pop(argument);
  }
}

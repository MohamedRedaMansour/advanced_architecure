import 'dart:developer';
import 'package:flutter/material.dart';

import '../../features/ui/screens/splash/splash_screen.dart';
import '../constants/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  log("Route Name:${settings.name}");
  log("Route arg:${settings.arguments}");
  switch (settings.name) {
    case RoutesNames.splashScreen:
      return MaterialPageRoute(
        builder: (context) => SplashScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => SplashScreen(),
      );
  }
}

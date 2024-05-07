import 'package:advanced_architecture_demo/core/environment/app_environment.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/DI/dependency_injector.dart';



final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


void main() async {

  await DependencyInjector(
    environment: EnvironmentType.development,
  ).injectModules();

  runApp(
    DevicePreview(enabled: false, builder: (context) => FintechApp()),
  );
}

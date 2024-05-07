import 'package:flutter/cupertino.dart';

class NestedNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigationKey;
  final String initialRoute;
  var RouteGeneration;

  NestedNavigator({
    required this.navigationKey,
    required this.initialRoute,
    required this.RouteGeneration,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Navigator(
          key: navigationKey,
          initialRoute: initialRoute,
          onGenerateRoute: RouteGeneration),
      onWillPop: () {
        if (navigationKey.currentState!.canPop()) {
          navigationKey.currentState!.pop();
          return Future<bool>.value(false);
        }
        return Future<bool>.value(true);
      },
    );
  }
}
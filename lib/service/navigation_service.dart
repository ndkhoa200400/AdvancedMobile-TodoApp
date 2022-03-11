import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<dynamic>? navigateTo(String routeName, Object? agrs) {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: agrs);
  }

  Future<dynamic>? push(var Page) {
    return navigatorKey.currentState?.push<void>(MaterialPageRoute<void>(
      builder: (BuildContext context) => Page(),
    ));
  }
}

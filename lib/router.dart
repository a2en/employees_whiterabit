import 'package:employees_app/ui/detail.dart';
import 'package:employees_app/ui/home.dart';
import 'package:flutter/material.dart';

import 'constants/app_constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RoutePaths.Detail:
        return MaterialPageRoute(builder: (_) => DetailPage(employee:settings.arguments as Map<String,Object?>?));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}
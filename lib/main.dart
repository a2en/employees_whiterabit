import 'package:employees_app/api/api.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';

import 'constants/app_colors.dart';
import 'constants/app_constants.dart';
import 'package:employees_app/router.dart' as rt;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee app',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          scaffoldBackgroundColor: primaryColor
      ),
      initialRoute: RoutePaths.Home,
      navigatorKey: NavigationService.navigationKey,
      onGenerateRoute: rt.Router.generateRoute,
    );
  }
}
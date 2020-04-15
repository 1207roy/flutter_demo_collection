import 'package:flutter/material.dart';
import 'package:auto_validating_form/app_routes.dart' as app_routes;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Auto Validation Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: app_routes.initialRoute,
      routes: app_routes.routesMap,
    );
  }
}
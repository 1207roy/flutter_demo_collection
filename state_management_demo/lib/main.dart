import 'package:flutter/material.dart';
import 'package:state_management/app_routes.dart' as app_routes;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: app_routes.initialRoute,
      routes: app_routes.routesMap,
    );
  }
}
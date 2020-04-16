import 'package:flutter/material.dart';
import 'package:auto_validating_form/app_routes.dart' as app_routes;

import 'package:bloc/bloc.dart';
import 'validation_using_bloc/simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
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
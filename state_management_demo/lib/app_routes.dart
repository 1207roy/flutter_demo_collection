import 'package:flutter/material.dart';
import 'package:state_management/flutter_bloc/flutter_bloc.dart';
import 'package:state_management/flutter_bloc_vanilla/flutter_bloc_vanilla.dart';
import 'package:state_management/flutter_redux/flutter_redux.dart';
import 'package:state_management/flutter_vanilla/flutter_vanilla.dart';
import 'package:state_management/home_page.dart';

/// This route will be the first screen that will be shown to the user
/// once user opens the app.
final String initialRoute = HomePage.routeName;

/// These routes will be used by the navigator to open the respective widget.
final Map<String, WidgetBuilder> routesMap = {
  HomePage.routeName: (context) => HomePage(),
  FlutterVanilla.routeName: (context) => FlutterVanilla(),
  FlutterBlocVanilla.routeName: (context) => FlutterBlocVanilla(),
  FlutterBloc.routeName: (context) => FlutterBloc(),
  FlutterRedux.routeName: (context) => FlutterRedux(),
};

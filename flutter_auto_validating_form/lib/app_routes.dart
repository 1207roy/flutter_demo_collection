import 'package:flutter/material.dart';
import 'package:auto_validating_form/home_page.dart';
import 'package:auto_validating_form/validation_using_global_key/login_screen.dart';
import 'package:auto_validating_form/validation_using_bloc/login_screen.dart';

/// This route will be the first screen that will be shown to the user
/// once user opens the app.
final String initialRoute = HomePage.routeName;

/// These routes will be used by the navigator to open the respective widget.
final Map<String, WidgetBuilder> routesMap = {
  HomePage.routeName: (context) => HomePage(),
  LoginScreenForValidationUsingGlobalKey.routeName: (context) => LoginScreenForValidationUsingGlobalKey(),
  LoginScreenForValidationUsingBloc.routeName: (context) => LoginScreenForValidationUsingBloc(),
};

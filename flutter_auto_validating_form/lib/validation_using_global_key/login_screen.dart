import 'package:flutter/material.dart';
import 'package:auto_validating_form/validation_using_global_key/login_form.dart';

class LoginScreenForValidationUsingGlobalKey extends StatelessWidget {
  static const String routeName = './validation_using_global_key';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page using Global key'),
      ),
      body: LoginForm(),
    );
  }
}
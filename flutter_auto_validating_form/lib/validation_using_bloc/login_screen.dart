import 'package:auto_validating_form/validation_using_bloc/bloc/bloc.dart';
import 'package:auto_validating_form/validation_using_bloc/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenForValidationUsingBloc extends StatefulWidget {
  static const String routeName = './validation_using_bloc';

  @override
  _LoginScreenForValidationUsingBlocState createState() => _LoginScreenForValidationUsingBlocState();
}

class _LoginScreenForValidationUsingBlocState extends State<LoginScreenForValidationUsingBloc> {
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page using bloc'),
      ),
      body: BlocProvider(
        create: (context) => _loginBloc,
        child: LoginForm(),
      ),
    );
  }
}

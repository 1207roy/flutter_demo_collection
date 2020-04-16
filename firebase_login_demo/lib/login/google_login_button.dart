import 'package:firebase_login_demo/login/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWithGoogle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.red,
      child: Text('Sign in with Google'),
      onPressed: () => BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed()),
    );
  }
}

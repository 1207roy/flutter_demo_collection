
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback _callback;

  LoginButton({@required VoidCallback callbackOnPressed}) : _callback = callbackOnPressed;

  @override
  Widget build(BuildContext context) {

    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text('Login'),
      onPressed: _callback,
    );
  }
}

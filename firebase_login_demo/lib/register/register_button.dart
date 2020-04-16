
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  bool _isButtonDisabled;
  final VoidCallback _callback;

  RegisterButton({@required VoidCallback callbackOnPressed}) : _callback = callbackOnPressed;

  @override
  Widget build(BuildContext context) {

    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text('Register'),
      onPressed: _callback,
    );
  }
}

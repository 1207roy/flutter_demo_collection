import 'package:firebase_login_demo/register/register_screen.dart';
import 'package:firebase_login_demo/user_repository.dart';
import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('Create New Account'),
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return RegisterScreen(userRepository: _userRepository);
              },
            )
        );
      },
    );
  }
}

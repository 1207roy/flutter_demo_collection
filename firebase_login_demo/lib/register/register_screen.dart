import 'package:firebase_login_demo/register/bloc/bloc.dart';
import 'package:firebase_login_demo/register/register_form.dart';
import 'package:firebase_login_demo/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  final UserRepository _userRepository;

  RegisterScreen({Key key, @required UserRepository userRepository})
      : _userRepository = userRepository,
        assert(userRepository != null),
        super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc(userRepository: widget._userRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      body: BlocProvider(
        create: (context) => _registerBloc,
        child: RegisterForm(),
      ),
    );
  }

  @override
  void dispose() {
    _registerBloc.close();
    super.dispose();
  }
}

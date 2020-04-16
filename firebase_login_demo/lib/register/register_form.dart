import 'package:firebase_login_demo/authentication/bloc.dart';
import 'package:firebase_login_demo/register/bloc/bloc.dart';
import 'package:firebase_login_demo/register/register_button.dart';
import 'package:firebase_login_demo/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (BuildContext context, RegisterState registerState) {
        if (registerState.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }

        if (registerState.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }

        if (registerState.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (BuildContext context, RegisterState registerState) {
          return Form(
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.9,
                heightFactor: 1.0,
                child: ListView(
                  children: <Widget>[
                    _buildEmailFormField(registerState),
                    _buildPasswordFormField(registerState),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildRegisterButton(registerState),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TextFormField _buildEmailFormField(RegisterState registerState) {
    return TextFormField(
      controller: _emailController,
      decoration:
      const InputDecoration(hintText: 'Email', icon: Icon(Icons.email)),
      keyboardType: TextInputType.emailAddress,
      autovalidate: true,
      validator: (String value) => _validateEmail(value, registerState),
    );
  }

  TextFormField _buildPasswordFormField(RegisterState registerState) {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
          hintText: 'Password', errorMaxLines: 2, icon: Icon(Icons.lock)),
      autovalidate: true,
      validator: (String value) => _validatePassword(value, registerState),
    );
  }

  String _validateEmail(String value, RegisterState registerState) {
    if (!registerState.isEmailValid) {
      return value.isEmpty ? 'Email is required' : 'Invalid Email';
    } else {
      return null;
    }
  }

  String _validatePassword(String value, RegisterState registerState) {
    if (!registerState.isPasswordValid) {
      return value.isEmpty
          ? 'Password is required'
          : 'Password should be minimum 8 chracters and should only contain alphanumberic value';
    } else {
      return null;
    }
  }

  Widget _buildRegisterButton(RegisterState registerState) {
    return RegisterButton(
        callbackOnPressed:
        isRegisterButtonEnabled(registerState) ? _onRegisterButtonPressed : null);
  }

  _onRegisterButtonPressed() {
    _registerBloc.add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  void _onEmailChanged() {
    _registerBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }
}
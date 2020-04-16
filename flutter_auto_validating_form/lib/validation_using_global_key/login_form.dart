import 'package:auto_validating_form/validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController;
  TextEditingController _passwordController;
  bool _autoValidate = false;
  ValueNotifier<bool> _isButtonDisabled;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _isButtonDisabled = ValueNotifier<bool>(false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        print(
            'onChanged called....isButtonDisabled: ${_isButtonDisabled.value}');
        if (_autoValidate) {
          if (_formKey.currentState.validate()) {
            if (_isButtonDisabled.value) {
              _isButtonDisabled.value = false;
            }
          } else {
            if (!_isButtonDisabled.value) {
              _isButtonDisabled.value = true;
            }
          }
        }
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          Size size = Size(constraints.maxWidth, constraints.maxHeight);

          return Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 1.0,
              child: ListView(
                children: <Widget>[
                  _buildLoginScreenIcon(size),
                  _buildEmailFormField(),
                  _buildPasswordFormField(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildLoginButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoginScreenIcon(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child:
          Image.asset('assets/flutter_logo.png', height: (size.height * 0.4)),
    );
  }

  TextFormField _buildEmailFormField() {
    return TextFormField(
      controller: _emailController,
      decoration:
          const InputDecoration(hintText: 'Email', icon: Icon(Icons.email)),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) => _validateEmail(value),
    );
  }

  TextFormField _buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
          hintText: 'Password', errorMaxLines: 2, icon: Icon(Icons.lock)),
      validator: (String value) => _validatePassword(value),
    );
  }

  Widget _buildLoginButton() {
    return ValueListenableBuilder(
      valueListenable: _isButtonDisabled,
      builder: (context, isButtonDisabled, child) {
        return LoginButton(
            callbackOnPressed: isButtonDisabled ? null : _onLoginButtonPressed);
      },
    );
  }

  _onLoginButtonPressed() {
    if (_formKey.currentState.validate()) {
      Fluttertoast.showToast(
          msg:
              'Login Successful with username: ${_emailController.text} pwd: ${_passwordController.text}');
    } else {
      _autoValidate = true;
      _isButtonDisabled.value = false;
    }
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return "Password is required";
    } else if (!Validators.isValidPassword(value)) {
      return "Password should be minimum 8 chracters and should only contain alphanumberic value";
    } else {
      return null;
    }
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return "Email is required";
    } else if (!Validators.isValidEmail(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback _callback;

  LoginButton({@required VoidCallback callbackOnPressed})
      : _callback = callbackOnPressed;

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

import 'package:firebase_login_demo/authentication/bloc.dart';
import 'package:firebase_login_demo/login/bloc/bloc.dart';
import 'package:firebase_login_demo/login/create_account_button.dart';
import 'package:firebase_login_demo/login/google_login_button.dart';
import 'package:firebase_login_demo/login/login_button.dart';
import 'package:firebase_login_demo/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  LoginBloc _loginBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
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
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState loginState) {
        if (loginState.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (loginState.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }

        if (loginState.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, LoginState loginState) {
          return Form(
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
                        _buildEmailFormField(loginState),
                        _buildPasswordFormField(loginState),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildLoginButton(loginState),
                              LoginWithGoogle(),
                              CreateAccountButton(
                                  userRepository: widget._userRepository),
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

  TextFormField _buildEmailFormField(LoginState loginState) {
    return TextFormField(
      controller: _emailController,
      decoration:
          const InputDecoration(hintText: 'Email', icon: Icon(Icons.email)),
      keyboardType: TextInputType.emailAddress,
      autovalidate: true,
      validator: (String value) => _validateEmail(value, loginState),
    );
  }

  TextFormField _buildPasswordFormField(LoginState loginState) {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
          hintText: 'Password', errorMaxLines: 2, icon: Icon(Icons.lock)),
      autovalidate: true,
      validator: (String value) => _validatePassword(value, loginState),
    );
  }

  String _validateEmail(String value, LoginState loginState) {
    if (!loginState.isEmailValid) {
      return value.isEmpty ? 'Email is required' : 'Invalid Email';
    } else {
      return null;
    }
  }

  String _validatePassword(String value, LoginState loginState) {
    if (!loginState.isPasswordValid) {
      return value.isEmpty
          ? 'Password is required'
          : 'Password should be minimum 8 chracters and should only contain alphanumberic value';
    } else {
      return null;
    }
  }

  Widget _buildLoginButton(LoginState loginState) {
    return LoginButton(
        callbackOnPressed:
            isLoginButtonEnabled(loginState) ? _onLoginButtonPressed : null);
  }

  _onLoginButtonPressed() {
    _loginBloc.add(
      LoginWithCredentialPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }
}

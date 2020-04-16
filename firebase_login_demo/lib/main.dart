import 'package:bloc/bloc.dart';
import 'package:firebase_login_demo/authentication/bloc.dart';
import 'package:firebase_login_demo/home/home_page.dart';
import 'package:firebase_login_demo/login/login_screen.dart';
import 'package:firebase_login_demo/simple_bloc_delegate.dart';
import 'package:firebase_login_demo/splash/splash_screen.dart';
import 'package:firebase_login_demo/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthenticationBloc _authenticationBloc;
  UserRepository userRepository;

  @override
  void initState() {
    super.initState();
    userRepository = UserRepository();
    _authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    _authenticationBloc.add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => _authenticationBloc,
      child: _buildMaterialApp(),
    );
  }

  Widget _buildMaterialApp() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder:
            (BuildContext context, AuthenticationState authenticationState) {
          print('Current Authentication State: $authenticationState');
          if (authenticationState is AuthenticationAuthenticated) {
            return HomePage(displayName: authenticationState.displayName);
          } else if (authenticationState is AuthenticationUnauthenticated) {
            return LoginScreen(userRepository: userRepository);
          }
//          else if (authenticationState is AuthenticationLoading) {
//            return LoadingIndicator();
//          }

          return SplashPage();
        },
      ),
    );
  }

  @override
  void dispose() {
    _authenticationBloc.close();
    super.dispose();
  }
}

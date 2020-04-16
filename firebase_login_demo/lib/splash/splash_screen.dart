import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        'Splash Screen',
        style: Theme.of(context).textTheme.headline5,
      ),
    ));
  }
}

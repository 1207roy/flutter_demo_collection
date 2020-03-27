import 'package:flutter/material.dart';

class FlutterBlocVanilla extends StatelessWidget {
  static const String routeName = './FlutterBlocVanilla';

  FlutterBlocVanilla({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Bloc Vanilla')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container();
  }
}

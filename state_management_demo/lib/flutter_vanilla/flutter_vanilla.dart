import 'package:flutter/material.dart';

class FlutterVanilla extends StatelessWidget {
  static const String routeName = './FlutterVanilla';

  FlutterVanilla({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Vanilla')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container();
  }
}

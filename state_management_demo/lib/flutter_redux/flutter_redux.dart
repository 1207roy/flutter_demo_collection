import 'package:flutter/material.dart';

class FlutterRedux extends StatelessWidget {
  static const String routeName = './FlutterRedux';

  FlutterRedux({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Redux')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container();
  }
}

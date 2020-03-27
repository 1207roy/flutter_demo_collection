import 'package:flutter/material.dart';

class FlutterBloc extends StatelessWidget {
  static const String routeName = './FlutterBloc';

  FlutterBloc({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Bloc')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container();
  }
}

import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Video Play Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Video Play Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String videoURL;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          RaisedButton(
            child: Text("Play from assets"),
            onPressed: _onPressedAssetPlay,
          ),
          RaisedButton(
            child: Text("Play from Device"),
            onPressed: () => _onPressedLocalPlay(context),
          ),
          RaisedButton(
            child: Text("Play from URL"),
            onPressed: _onPressedRemotePlay,
          )
        ],
      ),
    );
  }

  _onPressedAssetPlay() {}

  _onPressedLocalPlay(BuildContext context) {}

  _onPressedRemotePlay() {}
}

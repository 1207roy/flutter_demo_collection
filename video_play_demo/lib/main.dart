import 'dart:io';
import 'package:flutter/material.dart';
import 'package:videoplaydemo/video_remote_using_chewie.dart';
import 'package:videoplaydemo/video_remote_using_video_player.dart';

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
  String videoURL = 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';

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

  _onPressedRemotePlay() {
    Navigator.push(
        context,
        MaterialPageRoute(
          ///using Chewie library
          builder: (context) => VideoRemoteUsingChewie(videoURL: videoURL),
//          ///using video_player library
//          builder: (context) => VideoRemoteUsingVideoPlayer(videoURL: videoURL),
        ));
  }
}

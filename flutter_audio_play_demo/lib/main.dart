import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'audio_asset.dart';
import 'audio_local.dart';
import 'audio_remote.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  String audioURL =
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";

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

  _onPressedAssetPlay() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AudioAssets(audioFile: 'audio.mp3'),
        ));
  }

  _onPressedLocalPlay(BuildContext context) async {
    File audioFile = await FilePicker.getFile(type: FileType.audio);
    if (audioFile == null) {
      print("Audio Picked is null");
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AudioLocal(audioFile: audioFile),
          ));
    }
  }

  _onPressedRemotePlay() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AudioRemote(audioURL: audioURL),
        ));
  }
}

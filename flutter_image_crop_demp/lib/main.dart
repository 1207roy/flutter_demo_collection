import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Image Crop Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Image Crop Demo'),
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
  File imageFile;

  Future<Null> _pickImage() {
    //
  }

  Future<Null> _captureImage() {
    //
  }

  void _showImagePickerOption(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: _captureImage,
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(Icons.camera, size: 55.0),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                  RawMaterialButton(
                    onPressed: _pickImage,
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(Icons.sd_storage, size: 55.0),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: imageFile != null
            ? Image.file(imageFile)
            : Image.asset('assets/placeholder.jpg'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showImagePickerOption(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

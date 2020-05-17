import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

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
  String mobileNumber = '+919876543210';
  String url = 'http://flutter.dev';

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onPressedPhone,
            elevation: 2.0,
            fillColor: Colors.white,
            child: Icon(Icons.phone, size: 55.0),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          ),
          RawMaterialButton(
            onPressed: _onPressedSMS,
            elevation: 2.0,
            fillColor: Colors.white,
            child: Icon(Icons.textsms, size: 55.0),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          ),
          RawMaterialButton(
            onPressed: _onPressedUrl,
            elevation: 2.0,
            fillColor: Colors.white,
            child: Icon(Icons.link, size: 55.0),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          ),
        ],
      ),
    );
  }

  _onPressedPhone() {
    urlLauncher.launch("tel:+918200915091");
  }

  _onPressedSMS() {
    urlLauncher.launch("sms:+91820091509");
  }

  _onPressedUrl() {
    urlLauncher.launch(url);
  }
}

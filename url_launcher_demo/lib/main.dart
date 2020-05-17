import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {

    return Center(
      child: ListView(
        shrinkWrap: true,
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
        ],
      ),
    );
  }

  _onPressedPhone() {
  }

  _onPressedSMS() {
  }
}

import 'package:flutter/material.dart';
import 'package:flutterlocatordemo/geo_locator_service.dart' as geoLocator;
import 'package:geolocator/geolocator.dart';
import 'package:share/share.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Locator Demo',
      home: MyHomePage(title: 'Flutter Locator Demo'),
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
  Position _currentPosition;
  Placemark _currentPlaceMark;
  String _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Get Location'),
              onPressed: () => _getLocation(),
            ),
            Visibility(
              visible: _currentPosition != null,
              child: Text(
                  "LAT: ${_currentPosition?.latitude ?? ''}, LNG: ${_currentPosition?.longitude ?? ''}"),
            ),
            Visibility(
              visible: _currentPlaceMark != null,
              child: Text(
                  "Address: ${_currentPlaceMark?.locality ?? ''} ${_currentPlaceMark?.country ?? ''}, ${_currentPlaceMark?.postalCode ?? ''}"),
            ),
            Visibility(
              visible: _error != null,
              child: Text(
                  "Error: $_error"),
            ),
            Visibility(
              visible: _currentPlaceMark != null,
              child: FlatButton(
                child: Text('Share Location'),
                onPressed: () => Share.share(geoLocator.placeMarkDataToString(_currentPlaceMark)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getLocation() async {
    _error = null;
    print('before: geoPermisionStatus: ${await geoLocator.geolocationStatus}');

    _currentPosition = await geoLocator.currentPosition;
    print('after: geoPermisionStatus: ${await geoLocator.geolocationStatus}');
    _error = await geoLocator.errorMessage;

    if (_error == null) {
      _currentPlaceMark = await geoLocator.currentPlaceMark;
    }


    setState(() {});
  }
}

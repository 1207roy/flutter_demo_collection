import 'package:flutter/material.dart';

class FlutterVanilla extends StatefulWidget {
  static const String routeName = './FlutterVanilla';

  FlutterVanilla({
    Key key,
  }) : super(key: key);

  @override
  _FlutterVanillaState createState() => _FlutterVanillaState();
}

class _FlutterVanillaState extends State<FlutterVanilla> {
  int _counter = 0;
  void _incrementCounter() => setState(() { ++_counter; });
  void _decrementCounter() => setState(() { --_counter; });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Vanilla'),),
      body: _buildBody(context),
      floatingActionButton: _buildFloatingButtons(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Counter is at:', style: Theme.of(context).textTheme.headline5,),
          Text('$_counter', style: Theme.of(context).textTheme.headline3,),
        ],
      ),
    );
  }

  Widget _buildFloatingButtons() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            heroTag: 'addButton',
            child: Icon(Icons.add),
            onPressed: _incrementCounter,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
            heroTag: 'minusButton',
            child: Icon(Icons.remove),
            onPressed: _decrementCounter,
          ),
        ),
      ],
    );
  }
}

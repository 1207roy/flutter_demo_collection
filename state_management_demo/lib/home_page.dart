import 'package:flutter/material.dart';
import 'package:state_management/flutter_bloc/flutter_bloc.dart';
import 'package:state_management/flutter_bloc_vanilla/flutter_bloc_vanilla.dart';
import 'package:state_management/flutter_redux/flutter_redux.dart';
import 'package:state_management/flutter_vanilla/flutter_vanilla.dart';

class HomePage extends StatelessWidget {
  static const String routeName = './HomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('State Management Demo')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        alignment: Alignment.topRight,
        widthFactor: 0.8,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            _buildFlutterVanillaButton(context),
            _buildFlutterBlocVanillaButton(context),
            _buildFlutterBlocButton(context),
            _buildFlutterReduxButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFlutterVanillaButton(BuildContext context) {
    return RaisedButton(
      child: const Text('Flutter Vanilla'),
      onPressed: () => Navigator.pushNamed(context, FlutterVanilla.routeName),
    );
  }

  Widget _buildFlutterBlocVanillaButton(BuildContext context) {
    return RaisedButton(
      child: const Text('Flutter Bloc Vanilla (same as RxDart)'),
      onPressed: () => Navigator.pushNamed(context, FlutterBlocVanilla.routeName),
    );
  }

  Widget _buildFlutterBlocButton(BuildContext context) {
    return RaisedButton(
      child: const Text('Flutter Bloc'),
      onPressed: () => Navigator.pushNamed(context, FlutterBloc.routeName),
    );
  }

  Widget _buildFlutterReduxButton(BuildContext context) {
    return RaisedButton(
      child: const Text('Flutter Redux'),
      onPressed: () => Navigator.pushNamed(context, FlutterRedux.routeName),
    );
  }
}

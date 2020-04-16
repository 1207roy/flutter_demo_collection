import 'package:firebase_login_demo/authentication/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final String _name;
  HomePage({Key key, @required String displayName}) : assert(displayName != null), _name = displayName, super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home Page'),),
      body: Column(
        children: <Widget>[
          Center(child: Text('Welcome user $_name')),
          Align(
            alignment: Alignment.topRight,
            child: RaisedButton(
              child: Text('Logout'),
              onPressed: () => _authenticationBloc.add(LoggedOut()),
            ),
          )
        ],
      ),
    );
  }
}

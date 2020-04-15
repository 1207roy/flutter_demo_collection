import 'package:auto_validating_form/validation_using_bloc/login_screen.dart';
import 'package:auto_validating_form/validation_using_form/login_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String routeName = './HomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Auto-validation Demo')),
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
            _buildFlutterBlocButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFlutterVanillaButton(BuildContext context) {
    return RaisedButton(
      child: const Text('Auto validation using Form Widget'),
      onPressed: () => Navigator.pushNamed(context, LoginScreenForValidationUsingForm.routeName),
    );
  }

  Widget _buildFlutterBlocButton(BuildContext context) {
    return RaisedButton(
      child: const Text('Auto validation using Bloc'),
      onPressed: () => Navigator.pushNamed(context, LoginScreenForValidationUsingBloc.routeName),
    );
  }
}

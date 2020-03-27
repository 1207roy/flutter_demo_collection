import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/flutter_bloc/app_bloc/bloc.dart';

class FlutterBloc extends StatelessWidget {
  static const String routeName = './FlutterBloc';

  FlutterBloc({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: BlocWidget(),
    );
  }
}

class BlocWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Bloc'),),
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
          _buildCounterWidget(),
        ],
      ),
    );
  }

  Widget _buildCounterWidget() {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (BuildContext context, CounterState counterState) {
        print('widget counter: ${counterState.counter}');
        return Text('${counterState.counter}', style: Theme.of(context).textTheme.headline3,);
      },
    );
  }

  Widget _buildFloatingButtons() {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (BuildContext context, CounterState counterState) {
        CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
        return Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: 'addButton',
                child: Icon(Icons.add),
                onPressed: () => counterBloc.add(Increment(counterState.counter)),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                heroTag: 'minusButton',
                child: Icon(Icons.remove),
                onPressed: () => counterBloc.add(Decrement(counterState.counter)),
              ),
            ),
          ],
        );
      },
    );
  }
}
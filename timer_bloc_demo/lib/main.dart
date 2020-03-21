import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_bloc_demo/ticker.dart';

import 'app_bloc/bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer Bloc Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
//      this will provide us the bloc objects anywhere in the subtree, using either BlocBuilder or BlocProvider.of(context)
      home: BlocProvider(
        create: (context) => TimerBloc(ticker: Ticker()),
        child: Timer(
          title: 'Timer Bloc',
        ),
      ),
    );
  }
}

class Timer extends StatelessWidget {
  final String title;

  Timer({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _buildBody(context),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[_buildTimer(), _buildButton()],
    ),
  );
}

BlocBuilder<TimerBloc, TimerState> _buildTimer() {
  return BlocBuilder<TimerBloc, TimerState>(
    builder: (context, state) {
      final String min =
          ((state.duration / 60) % 60).floor().toString().padLeft(2, '0');
      final String sec =
          (state.duration % 60).floor().toString().padLeft(2, '0');
      print('min: $min');
      print('sec: $sec');

      return Text(
        '$min:$sec',
        style: Theme.of(context).textTheme.headline2,
      );
    },
  );
}

Widget _buildButton() {
  return BlocBuilder<TimerBloc, TimerState>(
    condition: (previousState, currentState) =>
        previousState.runtimeType != currentState.runtimeType,
    builder: (context, state) {
      return Action(
        timerBloc: BlocProvider.of<TimerBloc>(context),
      );
    },
  );
}

class Action extends StatelessWidget {
  final TimerBloc timerBloc;
  final TimerState timerState;

  Action({@required this.timerBloc}) : timerState = timerBloc.state;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _mapActionToState(),
    );
  }

  List<Widget> _mapActionToState() {
    if (timerState is Ready) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timerBloc.add(Start(duration: timerState.duration)),
        ),
      ];
    } else if (timerState is Running) {
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () => timerBloc.add(Pause()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(Reset()),
        ),
      ];
    } else if (timerState is Paused) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timerBloc.add(Resume()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(Reset()),
        ),
      ];
    } else if (timerState is Finished) {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(Reset()),
        ),
      ];
    }
    return [];
  }
}

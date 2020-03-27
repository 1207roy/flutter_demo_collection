
import 'dart:async';
//import 'package:rxdart/rxdart.dart';

import 'package:state_management/flutter_bloc_vanilla/app_bloc/bloc.dart';

class CounterBloc {
  ///state controller
  final StreamController<int> _counterStateController = StreamController<int>();
  //final PublishSubject<int> _counterStateController = PublishSubject<int>();
  StreamSink<int> get _inCounter => _counterStateController.sink;
  /// For state, exposing only a stream which outputs data
  Stream<int> get counter => _counterStateController.stream;

  ///event controller
  final StreamController<CounterEvent> _counterEventController = StreamController<CounterEvent>();
  //final PublishSubject<CounterEvent> _counterEventController = PublishSubject<CounterEvent>();
  /// For events, exposing only a sink which is an input
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    /// Whenever there is a new event, we want to map it to a new state
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is Increment) {
       _mapIncrementToState(event);
    } else if (event is Decrement) {
      _mapDecrementToState(event);
    }
  }

  int _count = 0;
  void _mapIncrementToState(Increment increment) {
    //update state
    _inCounter.add(++_count);
  }

  void _mapDecrementToState(Decrement decrement) {
    //update state
    _inCounter.add(--_count);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}

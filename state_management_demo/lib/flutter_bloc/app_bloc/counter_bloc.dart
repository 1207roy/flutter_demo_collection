import 'package:bloc/bloc.dart';
import 'package:state_management/flutter_bloc/app_bloc/bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final int _initialCounter = 0;

  CounterBloc();

  @override
  // TODO: implement initialState
  CounterState get initialState => CounterState(_initialCounter);

  @override
  void onTransition(Transition<CounterEvent, CounterState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is Increment) {
      yield* _mapIncrementToState(event);
    } else if (event is Decrement) {
      yield* _mapDecrementToState(event);
    }
  }

  Stream<CounterState> _mapIncrementToState(Increment increment) async* {
    print('_mapIncrementToState: Increment.counter: ${increment.counter} --> ${increment.counter + 1}');
    yield CounterState(increment.counter + 1);
  }

  Stream<CounterState> _mapDecrementToState(Decrement decrement) async* {
    print('_mapDecrementToState: Decrement.counter: ${decrement.counter} --> ${decrement.counter - 1}');
    yield CounterState(decrement.counter - 1);
  }
}

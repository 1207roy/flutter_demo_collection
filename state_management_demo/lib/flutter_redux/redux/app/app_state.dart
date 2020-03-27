import 'dart:ui';
import 'package:meta/meta.dart';

@immutable
class AppState{

  final int counterState;
  final int previousCounterState;
  final dynamic appAction;

  AppState({
    @required this.counterState,
    this.previousCounterState,
    this.appAction
  });

  factory AppState.initial(){
    return AppState(
      counterState: 0,
      previousCounterState: null,
      appAction: null,
    );
  }

//  AppState copyWith({
//    int state,
//    int previousState,
//    dynamic reduxAction,
//  }){
//    return AppState(
//      state: state ?? this.state,
//      previousState: previousState ?? this.previousState,
//      reduxAction: reduxAction ?? this.reduxAction,
//    );
//  }
//

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              counterState == other.counterState &&
              previousCounterState == other.previousCounterState;

  @override
  int get hashCode => hashValues(counterState, previousCounterState, appAction);
}
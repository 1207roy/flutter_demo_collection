import 'dart:ui';
import 'package:meta/meta.dart';

@immutable
class AppState{

  final int state;
  final int previousState;
  final dynamic appAction;

  AppState({
    @required this.state,
    this.previousState,
    this.appAction
  });

  factory AppState.initial(){
    return AppState(
      state: 0,
      previousState: null,
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
              state == other.state &&
              previousState == other.previousState;

  @override
  int get hashCode => hashValues(state, previousState, appAction);
}
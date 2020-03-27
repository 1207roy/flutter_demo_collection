


import 'package:state_management/flutter_redux/redux/app/app_action.dart';
import 'package:state_management/flutter_redux/redux/app/app_state.dart';

AppState appReducer(AppState appState, dynamic action) {
  switch (action) {
    case ReduxActions.Increment:
      return AppState(
        previousCounterState: appState.counterState,
        counterState: appState.counterState + 1,
        appAction: action,
      );
    case ReduxActions.Decrement:
      return AppState(
        previousCounterState: appState.counterState,
        counterState: appState.counterState - 1,
        appAction: action,
      );
    default:
      return appState;
  }
}


import 'package:flutter_redux_demo/redux/app/app_action.dart';
import 'package:flutter_redux_demo/redux/app/app_state.dart';

AppState appReducer(AppState appState, dynamic action) {
  switch (action) {
    case ReduxActions.Increment:
      return AppState(
        previousState: appState.state,
        state: appState.state + 1,
        appAction: action,
      );
    case ReduxActions.Decrement:
      return AppState(
        previousState: appState.state,
        state: appState.state - 1,
        appAction: action,
      );
    default:
      return appState;
  }
}

import 'package:flutter_redux_demo/redux/app/app_state.dart';
import 'package:redux/redux.dart';

class LoggingMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, dynamic action, NextDispatcher next) {
    print('this is the first LoggingMiddleware............action: $action on Currentstate: ${store.state.state}---PrevState: ${store.state.previousState} & prevAction: ${store.state.appAction}');

//    if(action == Actions.Increment) {
//      next(Actions.Decrement);  //you can change the Action type here for furthur middleware and reducer
//    } else {
      next(action);
//    }
  }
}
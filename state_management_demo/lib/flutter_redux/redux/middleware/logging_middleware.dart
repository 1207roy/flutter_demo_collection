
import 'package:redux/redux.dart';
import 'package:state_management/flutter_redux/redux/app/app_state.dart';

class LoggingMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, dynamic action, NextDispatcher next) {
    print('this is the first LoggingMiddleware............action: $action on Currentstate: ${store.state.counterState}---PrevState: ${store.state.previousCounterState} & prevAction: ${store.state.appAction}');

//    if(action == Actions.Increment) {
//      next(Actions.Decrement);  //you can change the Action type here for furthur middleware and reducer
//    } else {
      next(action);
//    }
  }
}
import 'package:redux/redux.dart';
import 'package:state_management/flutter_redux/redux/app/app_state.dart';

class SomeOtherMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, dynamic action, NextDispatcher next) {
    print('this is the second middleware............action: $action : state: ${store.state.counterState}');

//    if(action == Actions.Increment) {
//      next(Actions.Decrement);  //you can change the Action type here for further middleware and reducer
//    } else {
    next(action);
//    }
  }

}
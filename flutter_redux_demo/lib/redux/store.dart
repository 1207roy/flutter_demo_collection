import 'package:redux/redux.dart';

import 'app/app_reducer.dart';
import 'app/app_state.dart';
import 'middleware/logging_middleware.dart';
import 'middleware/some_other_middleware.dart';

Future<Store<AppState>> createStore() async{
  return Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      LoggingMiddleware(),
      SomeOtherMiddleware(),
    ],
  );
}
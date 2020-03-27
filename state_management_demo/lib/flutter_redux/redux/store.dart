import 'package:redux/redux.dart';
import 'package:state_management/flutter_redux/redux/app/app_reducer.dart';
import 'package:state_management/flutter_redux/redux/app/app_state.dart';
import 'package:state_management/flutter_redux/redux/middleware/logging_middleware.dart';
import 'package:state_management/flutter_redux/redux/middleware/some_other_middleware.dart';

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
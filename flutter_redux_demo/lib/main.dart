import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_demo/redux/app/app_action.dart';
import 'package:flutter_redux_demo/redux/app/app_state.dart';
import 'package:flutter_redux_demo/redux/store.dart';
import 'package:redux/redux.dart';

void main() async {
  var store = await createStore();
  runApp(FlutterReduxDemo(store));
}

class FlutterReduxDemo extends StatelessWidget {
  final Store<AppState> store;

  FlutterReduxDemo(
      this.store,
      {Key key,}
      ) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(
          body: StoreConnector<AppState, String>(
            converter: (store) {
              return store.state.state.toString();
            },
            builder: (context, count) {
              return Center(
                child: Text('You have pressed $count times'),
              );
            },
          ),
//           body: Center(
//             child: Text('You have pressed 0 times'),
//           ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              StoreConnector<AppState, VoidCallback>(
                converter: (store) {
                  return () => store.dispatch(ReduxActions.Increment);
                },
                builder: (context, callBack) {
                  return FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: callBack,
                  );
                },
              ),
              StoreConnector<AppState, VoidCallback>(
                converter: (store) {
                  return () => store.dispatch(ReduxActions.Decrement);
                },
                builder: (context, callBack) {
                  return FloatingActionButton(
                    child: Icon(Icons.remove),
                    onPressed: callBack,
                  );
                },
              ),
            ],
          ),
//           floatingActionButton: FloatingActionButton(
//             child: Icon(Icons.add),
//             onPressed: () {},
//           ),
        ),
      ),
    );
  }
}
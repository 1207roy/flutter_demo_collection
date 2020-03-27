import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:state_management/flutter_redux/redux/app/app_action.dart';

import 'package:state_management/flutter_redux/redux/app/app_state.dart';
import 'package:state_management/flutter_redux/redux/store.dart';

class FlutterRedux extends StatelessWidget {
  static const String routeName = './FlutterRedux';

  FlutterRedux({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: createStore(),
      builder: (context, AsyncSnapshot<Store<AppState>> snapshot) {
        if(!snapshot.hasData)  return Container();
        return ReduxDemo(snapshot.data);
      },
    );
  }
}

class ReduxDemo extends StatelessWidget {
  final Store<AppState> store;

  ReduxDemo(
      this.store,
      {Key key,}
      ) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        appBar: AppBar(title: Text('Flutter Redux'),),
        body: _buildBody(context),
        floatingActionButton: _buildFloatingButtons(),
        ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Counter is at:', style: Theme.of(context).textTheme.headline5,),
          _buildCounterWidget(),
        ],
      ),
    );
  }

  Widget _buildCounterWidget() {
    return StoreConnector<AppState, int>(
      converter: (Store<AppState> store) {
        return store.state.counterState;
      },
      builder: (BuildContext context, int count) {
        print('widget counter: $count');
        return Text('$count', style: Theme.of(context).textTheme.headline3,);
      },
    );
  }

  Widget _buildFloatingButtons() {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (Store<AppState> store) {
        return store;
      },
      builder: (BuildContext context, Store<AppState> store) {
        return Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: 'addButton',
                child: Icon(Icons.add),
                onPressed: () => store.dispatch(ReduxActions.Increment),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                heroTag: 'minusButton',
                child: Icon(Icons.remove),
                onPressed: () => store.dispatch(ReduxActions.Decrement),
              ),
            ),
          ],
        );
      },
    );
  }

//  Widget _buildAddFloatingButton() {
//    return StoreConnector<AppState, VoidCallback>(
//        converter: (store) {
//          return () => store.dispatch(ReduxActions.Increment);
//        },
//        builder: (context, callBack) {
//          return FloatingActionButton(
//            heroTag: 'addButton',
//            child: Icon(Icons.add),
//            onPressed: callBack,
//          );
//        },
//      );
//  }
//
//  Widget _buildMinusFloatingButton() {
//    return StoreConnector<AppState, VoidCallback>(
//      converter: (store) {
//        return () => store.dispatch(ReduxActions.Decrement);
//      },
//      builder: (context, callBack) {
//        return FloatingActionButton(
//          heroTag: 'minusButton',
//          child: Icon(Icons.remove),
//          onPressed: callBack,
//        );
//      },
//    );
//  }
}

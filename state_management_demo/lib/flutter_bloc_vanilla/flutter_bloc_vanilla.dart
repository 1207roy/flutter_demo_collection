import 'package:flutter/material.dart';
import 'package:state_management/flutter_bloc_vanilla/app_bloc/bloc.dart';

class FlutterBlocVanilla extends StatelessWidget {
  static const String routeName = './FlutterBlocVanilla';

  FlutterBlocVanilla({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VanillaBlocWidget(CounterBloc());
  }
}


class VanillaBlocWidget extends StatefulWidget {
  final CounterBloc counterBloc;

  VanillaBlocWidget(this.counterBloc);

  @override
  _VanillaBlocWidgetState createState() => _VanillaBlocWidgetState();
}

class _VanillaBlocWidgetState extends State<VanillaBlocWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Vanilla Bloc'),),
      body: _buildBody(context),
      floatingActionButton: _buildFloatingButtons(),
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
    return StreamBuilder(
      stream: widget.counterBloc.counter,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        print('widget counter: ${snapshot.data}');
        return Text('${snapshot.data}', style: Theme.of(context).textTheme.headline3,);
      },
    );
  }

  Widget _buildFloatingButtons() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            heroTag: 'addButton',
            child: Icon(Icons.add),
            onPressed: () => widget.counterBloc.counterEventSink.add(Increment()),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
            heroTag: 'minusButton',
            child: Icon(Icons.remove),
            onPressed: () => widget.counterBloc.counterEventSink.add(Decrement()),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.counterBloc.dispose();
  }
}

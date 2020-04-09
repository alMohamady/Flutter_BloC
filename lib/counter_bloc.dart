import 'dart:async';
import 'package:flutter_bloc_pattern/counter_event.dart';

class CounterBloc {

  int _counter = 0;

  final _counterStateController = StreamController<int>();
  StreamSink<int> get _inController => _counterStateController.sink;
  Stream<int> get outController =>  _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent> ();
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }
    _inController.add(_counter);
  }

  void dispose(){
    _counterStateController.close();
    _counterEventController.close();
  }
}

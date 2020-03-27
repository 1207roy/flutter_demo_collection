class CounterEvent {
  CounterEvent();
}

class Increment extends CounterEvent {
  int counter;

  Increment(this.counter);

  @override
  String toString() => 'Increment(counter: $counter)';
}

class Decrement extends CounterEvent {
  int counter;

  Decrement(this.counter);

  @override
  String toString() => 'Decrement(counter: $counter)';
}

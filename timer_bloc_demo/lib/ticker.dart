
///ticker class which provides tick on each seconds
class Ticker {
  Stream<int> tick({int ticks}) {
    print('Ticker(ticks: $ticks)');
    return Stream.periodic(Duration(seconds: 1), (x) {
      //x will be automatically incremented by Periodic Stream on every periodic duration(here on every 1 second)
      return ticks - x - 1;
    }).take(ticks);
  }
}
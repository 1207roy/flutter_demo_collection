import 'package:equatable/equatable.dart';

class TimerState extends Equatable {
  final int duration;

  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

//4 stat: Ready, Paused, Running, Finished

class Ready extends TimerState {
  const Ready(int duration) : super(duration);

  @override
  String toString() => 'Ready(duration: $duration)';
}

class Paused extends TimerState {
  const Paused(int duration) : super(duration);

  @override
  String toString() => 'Paused(duration: $duration)';
}

class Running extends TimerState {
  const Running(int duration) : super(duration);

  @override
  String toString() => 'Running(duration: $duration)';
}

class Finished extends TimerState {
  const Finished() : super(0);

  @override
  String toString() => 'Finished()';
}

import 'package:equatabl e/equatable.dart';
import 'package:flutter/cupertino.dart';

class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

//5 event: Start, Pause, Resume, Reset, Tick

class Start extends TimerEvent {
  final int duration;

  Start({@required this.duration});

  @override
  String toString() => 'Start(duration: $duration)';
}

class Pause extends TimerEvent {}

class Resume extends TimerEvent {}

class Reset extends TimerEvent {}

class Tick extends TimerEvent {
  final int duration;

  const Tick({@required this.duration});

  @override
  List<Object> get props => [duration];

  @override
  String toString() => 'Tick(duration: $duration)';
}

import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioLocal extends StatefulWidget {
  final File _audioFile;

  AudioLocal({@required audioFile})
      : _audioFile = audioFile,
        assert(audioFile != null);

  @override
  _AudioLocalState createState() => _AudioLocalState();
}


class _AudioLocalState extends State<AudioLocal> {
  static AudioPlayer audioPlayer = AudioPlayer();

  StreamSubscription _positionSubscription;
  StreamSubscription _playerStateSubscription;

  bool isStarted = false;
  ValueNotifier<Duration> _totalDuration;
  ValueNotifier<Duration> _currentDuration;
  ValueNotifier<bool> isPlaying;

  startPlaying() async {
    if (!isStarted) {
      await audioPlayer.play(widget._audioFile.path, isLocal: true);
      isStarted = true;
    } else
      await audioPlayer.resume();
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    audioPlayer.seek(newDuration);
  }

  @override
  void initState() {
    super.initState();
    _totalDuration = ValueNotifier<Duration>(new Duration());
    _currentDuration = ValueNotifier<Duration>(new Duration());
    isPlaying = ValueNotifier<bool>(false);

    _positionSubscription = audioPlayer.onAudioPositionChanged.listen((Duration p) async {
      _totalDuration.value = Duration(
        milliseconds: (await audioPlayer.getDuration()),
      );
      _currentDuration.value = p;

      print('Current duraion: $p');
      print('totla duration: ${_currentDuration.value}');

      double progress;
      if (_currentDuration.value == null || _totalDuration.value == null) {
        progress = 0.0;
      } else {
        progress = (_currentDuration.value.inMilliseconds) /
            _totalDuration.value.inMilliseconds;
      }
      print(progress);
    });

    _playerStateSubscription = audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      print("AudioPlayerState: $state");
      if (state == AudioPlayerState.PLAYING) {
        isPlaying.value = true;
      } else {
//        if (mounted) {
        isPlaying.value = false;
//        }
      }
    });
  }

  @override
  void dispose() async {
    await audioPlayer?.release();
    await audioPlayer?.dispose();
    _positionSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("Asset Audio Player"),
    );

    Widget _btnPlayPause = ValueListenableBuilder(
      valueListenable: isPlaying,
      builder: (context, value, child) {
        return IconButton(
          icon: Icon(
            value ? Icons.pause : Icons.play_arrow,
          ),
          onPressed: () {
            value ? audioPlayer.pause() : startPlaying();
            isPlaying.value = !isPlaying.value;
          },
        );
      },
    );

    Widget _audioSlider = ValueListenableBuilder(
      valueListenable: _currentDuration,
      builder: (_, Duration currentDuration, ___) {
        return Slider(
          value: currentDuration.inSeconds.toDouble(),
          min: 0.0,
          max: _totalDuration.value.inSeconds.toDouble(),
          onChanged: (double targetValue) {
            seekToSecond(targetValue.toInt());
          },
        );
      },
    );

    Widget _audioTimeLabels = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        ValueListenableBuilder(
          valueListenable: _currentDuration,
          builder: (context, value, child) {
            if (isStarted) {
              return Text(_getDurationInMMSS(value));
            } else {
              return Text("");
            }
          },
        ),
        Spacer(),
        ValueListenableBuilder(
          valueListenable: _totalDuration,
          builder: (context, value, child) {
            if (isStarted) {
              return Text(_getDurationInMMSS(value));
            } else {
              return Text("");
            }
          },
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        color: Colors.black,
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Container(
              height: appBar.preferredSize.height * 1.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(appBar.preferredSize.height),
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _btnPlayPause,
                        Expanded(child: _audioSlider),
                      ],
                    ),
                    _audioTimeLabels,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getDurationInMMSS(Duration duration) {
    String twoDigits(int n) {
      return n.toString().padLeft(2, '0');
    }

    int hour = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    if (hour > 0) {
      return "${twoDigits(hour)}:${twoDigits(minutes)}:${twoDigits(seconds)}";
    } else {
      return "${twoDigits(minutes)}:${twoDigits(seconds)}";
    }
  }
}

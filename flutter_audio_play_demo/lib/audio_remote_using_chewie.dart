import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// using video_player library
class AudioRemoteUsingChewie extends StatefulWidget {
  final String _audioURL;

  AudioRemoteUsingChewie({@required videoURL})
      : _audioURL = videoURL,
        assert(videoURL != null);

  @override
  _AudioRemoteUsingChewieState createState() => _AudioRemoteUsingChewieState();
}

class _AudioRemoteUsingChewieState extends State<AudioRemoteUsingChewie> {
  VideoPlayerController _videoPlayerController;
  ChewieAudioController _chewieAudioController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget._audioURL);
    _chewieAudioController = ChewieAudioController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieAudioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video From Network Using Chewie"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: ChewieAudio(
                controller: _chewieAudioController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

/// using video_player library
class VideoRemoteUsingVideoPlayer extends StatefulWidget {
  final String _videoURL;

  VideoRemoteUsingVideoPlayer({@required videoURL})
      : _videoURL = videoURL,
        assert(videoURL != null);
  @override
  _VideoRemoteUsingVideoPlayerState createState() => _VideoRemoteUsingVideoPlayerState();
}

class _VideoRemoteUsingVideoPlayerState extends State<VideoRemoteUsingVideoPlayer> {
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget._videoURL);
    _videoPlayerController
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _videoPlayerController.setLooping(true);
        setState(() {});
      });
    _videoPlayerController..addListener(() {
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController.removeListener(() {});
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video From Network Using Video Player"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            _videoPlayerController.value.initialized
                ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            )
                : Container(),
            Center(
              child: IconButton(
                icon: Icon(
                  _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
                onPressed: () {
                  _videoPlayerController.value.isPlaying ? _videoPlayerController.pause() : _videoPlayerController.play();
                  setState(() {

                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
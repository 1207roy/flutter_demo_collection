import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// using video_player library
class VideoAssetUsingChewie extends StatefulWidget {
  final String _videoAssetPath;

  VideoAssetUsingChewie({@required videoAssetPath})
      : _videoAssetPath = videoAssetPath,
        assert(videoAssetPath != null);

  @override
  _VideoAssetUsingChewieState createState() =>
      _VideoAssetUsingChewieState();
}

class _VideoAssetUsingChewieState extends State<VideoAssetUsingChewie> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(widget._videoAssetPath);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
//      aspectRatio: 3 / 2,
      aspectRatio: _videoPlayerController.value.aspectRatio,
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
    _chewieController.dispose();
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
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

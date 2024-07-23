import 'package:flutter/material.dart';
import 'package:learningapp/core/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerPage({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    play(widget.videoUrl);
  }

  void play(String videoUrl) {
    final convertUrl = YoutubePlayer.convertUrlToId(videoUrl);
    if (convertUrl == null) {
      print('Failed to convert URL to ID');
      return;
    }
    print('Video ID: $convertUrl');
    _controller = YoutubePlayerController(
      initialVideoId: convertUrl,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: false,
      ),
    )..addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }


  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> listener() async {
    if (mounted) {
      print('setState');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kcolor,
        title: const Text('Youtube Player'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          if (_controller != null) // Check if the controller is not null
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: false,
                onReady: () {
                  _controller.addListener(listener);
                },
              ),
            ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                  setState(() {});
                },
                iconSize: 42,
                color: _controller.value.isPlaying ? Colors.red : Kcolor,
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

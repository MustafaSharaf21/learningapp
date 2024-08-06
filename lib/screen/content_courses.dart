import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:learningapp/core/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../data/http.dart';

class ContentCourses extends StatefulWidget {
  final int courseId;

  ContentCourses(this.courseId);

  @override
  _ContentCoursesState createState() => _ContentCoursesState();
}

class _ContentCoursesState extends State<ContentCourses> {
  List videos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    try {
      final response = await HttpHelper.gettData(
        url: 'content/show/${widget.courseId}',
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        setState(() {
          videos = data;
          isLoading = false;
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _openContent(String type, String url) {
    if (type == 'video') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerPage(videoUrl: url),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DocumentViewer2(documentUrl: url),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Content for Course ${widget.courseId}',
          style: const TextStyle(color: Kcolor),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _openContent(videos[index]['type'], videos[index]['url']);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 20.0, bottom: 20, left: 20, top: 2),
              child: Container(
                height: 115,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 26,),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 12.0, right: 7),
                              child: Text(
                                videos[index]['name'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'cairo'),
                              ),
                            ),

                            const Spacer(),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            color: Colors.white,
                            child: SizedBox(
                              width: videos[index]['type'] == 'video' ? 100 : 100,
                              height: videos[index]['type'] == 'video' ? 70 : 70,
                              child: Image.asset(
                                videos[index]['type'] == 'video'
                                    ? 'assets/images/video_14044100.png'
                                    : 'assets/images/edit(2).png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 3,),
                          const Text('EDUspark'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  VideoPlayerPage({required this.videoUrl});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    play();
  }

  Future<void> play() async {
    final convertUrl = YoutubePlayer.convertUrlToId(widget.videoUrl);
    if (convertUrl == null) return;
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
    _controller?.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: const Text('Youtube Player'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: YoutubePlayer(
              controller: _controller!,
              showVideoProgressIndicator: false,
              onReady: () {
                _controller?.addListener(() {
                  if (mounted) {
                    setState(() {});
                  }
                });
              },
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (_controller!.value.isPlaying) {
                    _controller!.pause();
                  } else {
                    _controller!.play();
                  }
                  setState(() {});
                },
                iconSize: 42,
                color: _controller!.value.isPlaying ? Colors.red : Colors.green,
                icon: Icon(
                  _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DocumentViewer2 extends StatelessWidget {
  final String documentUrl;

  const DocumentViewer2({Key? key, required this.documentUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Viewer'),
      ),
      body: const PDF().cachedFromUrl(
        documentUrl,
        placeholder: (progress) => Center(child: Text('$progress %')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
    );
  }
}

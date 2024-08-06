import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:learningapp/core/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../data/http.dart';
import 'PdfViewerPage.dart';
import 'content_courses.dart';

class ContentCoursesSpes extends StatefulWidget {
  final int courseId;

  ContentCoursesSpes(this.courseId);

  @override
  _ContentCoursesSpesState createState() => _ContentCoursesSpesState();
}

class _ContentCoursesSpesState extends State<ContentCoursesSpes> {
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
          builder: (context) => DocumentViewer(documentUrl: url),
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
                        ],//uu
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


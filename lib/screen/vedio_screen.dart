import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learningapp/screen/vedio_player_screen.dart';
import '../data/http.dart';


class Vedio extends StatefulWidget {
  const Vedio({Key? key}) : super(key: key);

  @override
  State<Vedio> createState() => _CourcesState();
}

class _CourcesState extends State<Vedio> {
  List<dynamic> videos = [];
  List<String> videoUrls = [
    'https://youtu.be/I7XVS0EySXs',
    'https://youtu.be/I7XVS0EySXs',
    'https://youtu.be/I7XVS0EySXs',
    'https://youtu.be/I7XVS0EySXs',
    'https://youtu.be/I7XVS0EySXs',
    'https://youtu.be/I7XVS0EySXs',
    'https://youtu.be/I7XVS0EySXs',

  ];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.63:8000/api/Home/Getvideos_tapbar'),
        headers: {'Authorization': 'Bearer $token'},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerPage(
                videoUrl: videoUrls[index],
                ),)
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0,bottom: 20,left: 20,top: 2),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
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
                            Text(
                              video['name'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Type: ${video['type']}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            Spacer(),
                            Text(
                             ' ${video['url']}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          'assets/images/vedio.jpg',
                          fit: BoxFit.cover,
                        ),
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


//
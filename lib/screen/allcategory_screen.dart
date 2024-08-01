import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flip_card/flip_card.dart';

import '../data/http.dart';
import 'content_courses.dart';

class allCategory extends StatefulWidget {
  const allCategory({super.key});

  @override
  State<allCategory> createState() => _ExampleState();
}

class _ExampleState extends State<allCategory> {
  List<dynamic> lastUpdatedCourses = [];
  List<dynamic> randomRelatedCourses = [];
  List<dynamic> trendCountryCourses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLastUpdatedCourses();
    fetchrandomRelatedCourses();
    fetchTrendCountryCourses();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildSection('stay updated', lastUpdatedCourses),
          buildSection('in your profession', randomRelatedCourses),
          buildSection('trend in your country', trendCountryCourses),
        ],
      ),
    );
  }

  Widget buildSection(String title, List<dynamic> courses) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                final imageUrl = course['image'] != null
                    ? 'http://192.168.43.63:8000' + course['image']
                    : 'assets/images/default.jpg';

                final flipCardKey = GlobalKey<FlipCardState>();

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContentCourses(course['id']),
                      ),
                    );
                  },
                  child: FlipCard(
                    key: flipCardKey,
                    direction: FlipDirection.HORIZONTAL,
                    flipOnTouch: false, // Disable flipping on tap
                    front: buildCourseCard(course, imageUrl, flipCardKey),
                    back: buildCourseDescriptionCard(course, flipCardKey),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCourseCard(dynamic course, String imageUrl, GlobalKey<FlipCardState> flipCardKey) {
    return Container(
      width: 142,
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F7),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 180,
      margin: EdgeInsets.only(left: 10, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0, top: 2.8),
            child: Container(
              height: 130,
              width: 120,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl),
                ),
              ),
            ),
          ),
          Text(
            truncateWithEllipsis(16, course['name'] ?? 'Unknown'),
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.auto_fix_high,
                    color: Color(0xFF399679),
                    size: 18,
                  ),
                  Text(
                    truncateWithEllipsis(16, course['author_name']?.toString() ?? 'Unknown'),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  flipCardKey.currentState?.toggleCard();
                },
                child: Row(
                  children: [
                    Text(
                      "info",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Icon(
                      Icons.warning,
                      color: Color(0xFF399679),
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCourseDescriptionCard(dynamic course, GlobalKey<FlipCardState> flipCardKey) {
    return Container(
      width: 142,
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F7),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 180,
      margin: EdgeInsets.only(left: 10, right: 15),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 10), // Add spacing at the top
                Flexible(
                  child: SingleChildScrollView(
                    child: Text(
                      course['description'] ?? 'No description available.',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.grey, size: 18),
              onPressed: () {
                flipCardKey.currentState?.toggleCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff) ? myString : '${myString.substring(0, cutoff)}...';
  }

  Future<void> fetchLastUpdatedCourses() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.63:8000/api/Home/last_updated_courses'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        setState(() {
          lastUpdatedCourses = data;
          isLoading = false;
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchrandomRelatedCourses() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.63:8000/api/Home/rand_related_courses'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        setState(() {
          randomRelatedCourses = data;
          isLoading = false;
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchTrendCountryCourses() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.63:8000/api/Home/trend_Country_courses'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        setState(() {
          trendCountryCourses = data;
          isLoading = false;
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
//mustafa

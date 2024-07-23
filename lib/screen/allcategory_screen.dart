import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/http.dart';

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
      child: Column(children: [
        Text(
          "الاكثر...",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: lastUpdatedCourses.length,
            itemBuilder: (context, index) {
              final lastUpdate = lastUpdatedCourses[index];
              final imageUrl = lastUpdate['image'] != null
                  ? 'http://192.168.118.128:8000' + lastUpdate['image']
                  : 'assets/images/default.jpg';
              return GestureDetector(
                onTap: () {
                  setState(() {
                    // images=index;
                  });
                },
                child: Container(
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
                              image: NetworkImage(
                                lastUpdate['image'] != null
                                    ? 'http://192.168.118.128:8000' +
                                        lastUpdate['image']
                                    : 'assets/images/default.jpg',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        lastUpdate['name'] ?? 'Unknown',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
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
                                lastUpdate['author_name']?.toString() ??
                                    'Unknown',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Text(
                                "pdf",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Icon(
                                Icons.picture_as_pdf,
                                color: Color(0xFF399679),
                                size: 18,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Text(
          "الاكثر...",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          height: 180,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: randomRelatedCourses.length,
              itemBuilder: (context, index) {
                final randomcourses = randomRelatedCourses[index];
                final imageUrl = randomcourses['image'] != null
                    ? 'http://192.168.118.128:8000' + randomcourses['image']
                    : 'assets/images/vedio.jpg';
                return GestureDetector(
                  onTap: () {
                    setState(() {
      // images=index;
                    });
                  },
                  child: Container(
                    width: 142,
                    decoration: BoxDecoration(
                      color: Color(0xFFFAFAF6),
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
                                image:  NetworkImage(
                                  randomcourses['image'] != null
                                      ? 'http://192.168.118.128:8000' +
                                      randomcourses['image']
                                      : 'assets/images/artificalIntelligence.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          randomcourses['name'] ?? 'Unknown',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold,
                          fontSize: 12),
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
                                  randomcourses['author_name']?.toString() ??
                                      'Unknown',
                                  style: TextStyle(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Text(
                                  "pdf",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Icon(
                                  Icons.picture_as_pdf,
                                  color: Color(0xFF399679),
                                  size: 18,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        Text(
          "الاكثر...",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: trendCountryCourses.length,
            itemBuilder: (context, index) {
              final trendCourses = trendCountryCourses[index];
              final imageUrl = trendCourses['image'] != null
                  ? 'http://192.168.118.128:8000' + trendCourses['image']
                  : 'assets/images/artificalIntelligence.png';
              return GestureDetector(
                onTap: () {
                  setState(() {
                    // images=index;
                  });
                },
                child: Container(
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
                              image: NetworkImage(
                                trendCourses['image'] != null
                                    ? 'http://192.168.118.128:8000' +
                                    trendCourses['image']
                                    : 'assets/images/artificalIntelligence.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        trendCourses['name'] ?? 'Unknown',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
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
                                trendCourses['author_name']?.toString() ??
                                    'Unknown',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Text(
                                "pdf",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Icon(
                                Icons.picture_as_pdf,
                                color: Color(0xFF399679),
                                size: 18,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }

  Future<void> fetchLastUpdatedCourses() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.118.128:8000/api/Home/last_updated_courses'),
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
        Uri.parse('http://192.168.118.128:8000/api/Home/rand_related_courses'),
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
        Uri.parse('http://192.168.118.128:8000/api/Home/trend_Country_courses'),
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

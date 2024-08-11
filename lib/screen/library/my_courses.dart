import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../core/constants.dart';
import '../../data/http.dart';
import '../content_courses_spes.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  List<dynamic> my_courses = [];
  bool isLoading = true;
  bool noCourses = false; // حالة جديدة للتحقق من عدم وجود دورات

  @override
  void initState() {
    super.initState();
    fetchMyCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Courses'),
        backgroundColor: Kcolor,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : noCourses
          ? Center(
        child: Text(
          'There are not any enrolled courses now',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      )
          : ListView.builder(
        itemCount: my_courses.length,
        itemBuilder: (context, index) {
          final course = my_courses[index];
          final courseName = course['name'] ?? 'No Name Available';
          final courseImage = course['image'] ?? 'assets/images/creatTest3.jpg';
          final courseDesc = course['description'] ?? 'No description available';
          final courseAuthor = course['author_name'] ?? 'No description available';
          final coursespec = course['specialization_name'] ?? 'No description available';
          final courseId = course['id'];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContentCoursesSpes(courseId),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Container(
                height: 158,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3, // زيادة نسبة الواجهة للصورة
                      child: Column(mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                '$imgURL$courseImage',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 150, // تعيين ارتفاع ثابت للصورة
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/creatTest3.jpg',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(onTap: (){
                              unjoin(courseId);
                            },
                              child: Row(
                                children: [
                                  Icon(Icons.join_inner_sharp),
                                  SizedBox(width: 5,),
                                  Text('unjoin')
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2, // نسبة الواجهة للمحتوى
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              courseName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 1.5),
                            Text(
                              courseDesc,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  courseAuthor,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  coursespec,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> fetchMyCourses() async {
    try {
      final response = await HttpHelper.gettData(url: 'sidebar/getmycourses');
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        setState(() {
          my_courses = data;
          isLoading = false;
          noCourses = my_courses.isEmpty;
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<void> unjoin(int courseId) async {
    await HttpHelper.postData(url: 'sidebar/unjoinofcourse/$courseId').then((value) {
      Map<String, dynamic> res = jsonDecode(value.body);
      if (value.statusCode == 200 || value.statusCode == 201) {

       print('un joined success');
        Get.snackbar(
          'Success',
          res['status'].toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          res['status'].toString(),
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      }
    });
  }
}

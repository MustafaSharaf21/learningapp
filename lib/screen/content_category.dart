import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../data/http.dart';
import '../screen/category_screen.dart';
import 'content_courses_spes.dart'; // استدعاء كلاس المحتوى

class CoursesPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const CoursesPage({Key? key, required this.categoryId, required this.categoryName}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  List<dynamic> courses = [];
  bool isLoading = true;
  final GetStorage storage = GetStorage();
  Set<int> joinedCourses = Set<int>(); // لتتبع الدورات التي انضم إليها المستخدم

  @override
  void initState() {
    super.initState();
    loadJoinedCourses(); // تحميل الدورات التي انضم إليها المستخدم عند بدء الصفحة
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      final response = await HttpHelper.gettData(url: 'Specialization/getcourses/${widget.categoryId}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        setState(() {
          courses = data;
          isLoading = false;
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> loadJoinedCourses() async {
    final storedCourses = storage.read<List<int>>('joined_courses') ?? [];
    setState(() {
      joinedCourses = Set<int>.from(storedCourses);
    });
  }

  Future<void> saveJoinedCourses() async {
    await storage.write('joined_courses', joinedCourses.toList());
  }

  Future<void> join(int courseId) async {
    await HttpHelper.postData(url: 'course/enrollment/$courseId').then((value) {
      Map<String, dynamic> res = jsonDecode(value.body);
      if (value.statusCode == 200 || value.statusCode == 201) {
        setState(() {
          joinedCourses.add(courseId); // إضافة الدورة إلى قائمة الانضمام
        });
        saveJoinedCourses(); // حفظ حالة الانضمام
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: Kcolor,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          final courseName = course['name'] ?? 'No Name Available';
          final courseImage = course['image'] ?? 'assets/images/creatTest3.jpg';
          final coursedesc = course['description'] ?? 'No description available';
          final courseId = course['id'];

          final isJoined = joinedCourses.contains(courseId);

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
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Row(
                  children: [
                    Expanded(
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
                            SizedBox(height: 5),
                            Text(
                              coursedesc,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (!isJoined) {
                                      join(courseId);
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        isJoined ? Icons.check : Icons.join_inner_sharp,
                                        size: 20,
                                        color: Color(0xffEC7D7F),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        isJoined ? 'Joined' : 'Join',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text("Author"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            '$imgURL'+courseImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/creatTest3.jpg',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
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
}

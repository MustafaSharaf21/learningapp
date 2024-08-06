import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learningapp/screen/my_contants.dart';
import '../core/constants.dart';
import '../data/http.dart';
import '../data/models/Getx_Controller.dart';
import 'add_course_page/add_course_page.dart';
import 'package:http/http.dart' as http;

class ContentManagement extends StatefulWidget {
  const ContentManagement({super.key});

  @override
  State<ContentManagement> createState() => _ContentManagementState();
}

class _ContentManagementState extends State<ContentManagement> {
  List<bool> selectedComponents = List.generate(10, (index) => false);
  bool showCheckboxes = false;

  void selectAll() {
    setState(() {
      for (int i = 0; i < selectedComponents.length; i++) {
        selectedComponents[i] = true;
      }
      showCheckboxes = true; // عرض مربعات الاختيار
    });
  }

  List<dynamic> createCourse = [];

  @override
  void initState() {
    fetchCreateCourse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCoursesPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Kcolor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "courses",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: createCourse.isNotEmpty
          ? ListView.builder(
        itemCount: createCourse.length,
        itemBuilder: (context, index) {
          var createCourseItem = createCourse[index];
          final courseImage =
              createCourseItem['image'] ?? 'assets/images/creatTest1.jpg';
          final courseId = createCourseItem['id'] ?? '';
          Get.find<UserRoleController>().setRoleId(courseId);
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return myContents();
              }));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Row(
                  children: [
                    if (showCheckboxes) ...[
                      Checkbox(
                        value: selectedComponents[index],
                        onChanged: (bool? value) {
                          setState(() {
                            selectedComponents[index] = value!;
                          });
                        },
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              PopupMenuButton<String>(
                                onSelected: (String value) {
                                  if (value == 'delete') {
                                    deleteCourse(courseId, index);
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: "update",
                                    child: Text("update"),
                                  ),
                                  PopupMenuItem<String>(
                                    value: "delete",
                                    child: Text("delete"),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 50,
                                width: 185,
                                child: Text(
                                  createCourseItem['name'] ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 50,
                            width: 235,
                            child: Text(
                              createCourseItem['description'] ?? '',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(
                                height: 20,
                                width: 170,
                                child: Text(
                                  createCourseItem[
                                  'specialization_id'] ??
                                      '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.mode_standby,
                                    size: 12,
                                    color: createCourseItem['status'] ==
                                        'pending'
                                        ? Colors.red
                                        : createCourseItem['status'] ==
                                        'accepted'
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 55,
                                    child: Text(
                                      createCourseItem['status'] ?? '',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            '$imgURL' + courseImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder:
                                (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/creatTest1.jpg',
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
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> fetchCreateCourse() async {
    try {
      final response = await http.get(
        Uri.parse('$baseurl' + 'course/show'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response body: ${response.body}'); // طباعة الاستجابة الكاملة
        var responseData = jsonDecode(response.body);
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data')) {
          setState(() {
            createCourse = responseData['data'];
          });
          Get.snackbar(
            'Success',
            'Data fetched successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.greenAccent,
            colorText: Colors.white,
          );
        } else {
          print('Error: Unexpected response format');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteCourse(int courseId, int index) async {
    try {
      final response = await http.post(
        Uri.parse('$baseurl' + 'course/delete/$courseId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response body: ${response.body}'); // طباعة الاستجابة الكاملة
        var responseData = jsonDecode(response.body);
        if (responseData['status'] == 'Success') {
          setState(() {
            createCourse.removeAt(index);
          });
          Get.snackbar(
            'Success',
            'The course is deleted successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.greenAccent,
            colorText: Colors.white,
          );
        } else {
          print('Error: Unexpected response format');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

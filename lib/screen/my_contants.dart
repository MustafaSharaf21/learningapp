import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learningapp/generated/l10n.dart';
import '../core/constants.dart';
import '../data/http.dart';
import 'package:http/http.dart' as http;
import '../data/models/Getx_Controller.dart';
import 'Update_content_screen.dart';
import 'content_courses.dart';
import 'create_myContents.dart';

class myContents extends StatefulWidget {
  static String id = "myContents";
  myContents({super.key});

  @override
  State<myContents> createState() => _myContentsState();
}

class _myContentsState extends State<myContents> {
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

  List<dynamic> myContents = [];
  List videos = [];

  @override
  void initState() {
    super.initState();
    fetchContents();
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
                  builder: (context) => createMyContents(),
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
          "My Contents",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: myContents.isNotEmpty
          ? ListView.builder(
        itemCount: myContents.length,
        itemBuilder: (context, index) {
          var myContentsItem = myContents[index];
          //final courseId= myContentsItem['course_id'] ?? '';
          //Get.find<UserRoleController>().setcourseId(courseId);
          int contentId = myContentsItem['id'] ?? '';
          String typeId = myContentsItem['type_id'].toString();
          String contentType = typeId == '1' ? 'video' : 'pdf';
          return GestureDetector(
            onTap: () {
              if (index < videos.length) {
                _openContent(videos[index]['type'], videos[index]['url']);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
              child: Container(
                height: 100,
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
                                    deleteContent(contentId, index);
                                  } else if (value == 'update') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateContentPage(contents: myContentsItem),
                                      ),
                                    ).then((value) {
                                      if (value == true) {
                                        fetchContents();
                                      }
                                    });
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
                              Column(
                                children: [
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 40,
                                    width: 185,
                                    child: Text(
                                      myContentsItem['name'] ?? '',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 15),
                                  SizedBox(
                                    height: 20,
                                    width: 160,
                                    child: Text(
                                      contentType,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.mode_standby,
                                    size: 12,
                                    color: myContentsItem['status'] ==
                                        'pending'
                                        ? Colors.red
                                        : myContentsItem['status'] ==
                                        'accepted'
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 50,
                                    child: Text(
                                      myContentsItem['status'] ?? '',
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
                    Column(
                      children: [
                        Container(
                          color: Colors.white,
                          child: SizedBox(
                            width: 100,
                            height: 70,
                            child: Image.asset(
                              videos.isNotEmpty &&
                                  videos[index]['type'] == 'video'
                                  ? 'assets/images/video_14044100.png'
                                  : 'assets/images/edit(2).png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        const Text('EDUspark'),
                      ],
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

  void fetchContents() async {
    await fetchmyContents();
    await fetchVideos();
  }

  Future<void> fetchmyContents() async {
    final courseId = Get.find<UserRoleController>().courseId.value;
    try {
      final response = await http.get(
        Uri.parse('$baseurl' + 'content/show/${courseId}'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response body: ${response.body}');
        var responseData = jsonDecode(response.body);
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data')) {
          setState(() {
            myContents = responseData['data'];
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

  Future<void> fetchVideos() async {
    final courseId = Get.find<UserRoleController>().courseId.value;
    try {
      final response = await HttpHelper.gettData(
        url: 'content/show/${courseId}',
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        setState(() {
          videos = data;
        });
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteContent(int contentId, int index) async {
    try {
      final response = await http.post(
        Uri.parse('$baseurl' + 'content/delete/$contentId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response body: ${response.body}');
        var responseData = jsonDecode(response.body);
        if (responseData['status'] == 'Success') {
          setState(() {
            myContents.removeAt(index);
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

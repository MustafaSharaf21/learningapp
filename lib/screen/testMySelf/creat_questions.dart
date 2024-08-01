import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';
import '../../data/http.dart';
import '../../generated/l10n.dart';
import 'quiz_list.dart';

class CreatQuestion extends StatefulWidget {
  @override
  _CreatQuestionState createState() => _CreatQuestionState();
}

class _CreatQuestionState extends State<CreatQuestion> {
  TextEditingController testTitlecontroller = TextEditingController();
  int? selectedNumber;
  List<QuestionContainer> questionContainers = [];
  String? testTitle;
  List<DropdownMenuItem<int>> CoursesItems = [];
  Map<String, dynamic> Courses = {};
  String? selectedCourses;
  int? selectedCoursesId;
  final List<int> numbers = List.generate(11, (index) => index + 5);

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Kcolor,
          title: Text('Create Test'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 128,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Kcolor, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: DropdownButton<int>(
                                borderRadius: BorderRadius.circular(10),
                                icon: const Icon(Icons.arrow_drop_down, color: Kcolor),
                                dropdownColor: Colors.white,
                                hint: Text(
                                  selectedCourses ?? "S.of(context).Courses",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF464241),
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                items: CoursesItems,
                                onChanged: (int? item) {
                                  setState(() {
                                    GetStorage().write('selectedCountryId', item);
                                    selectedCoursesId = item;
                                    selectedCourses = item != null ? Courses['data'].firstWhere((c) => c['id'] == item)['name'] : null;
                                  });
                                  print('Selected Specialize ID: $item');
                                  print('Specialize id to back: $selectedCoursesId');
                                },

                                value: selectedCoursesId,
                                isExpanded: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Kcolor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<int>(
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Number of Questions", style: TextStyle(color: Colors.black)),
                        ),
                        value: selectedNumber,
                        onChanged: (newValue) {
                          setState(() {
                            selectedNumber = newValue;
                            questionContainers = List.generate(selectedNumber!, (index) => QuestionContainer(index: index));
                          });
                        },
                        items: numbers.map((number) {
                          return DropdownMenuItem<int>(
                            value: number,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(number.toString()),
                            ),
                          );
                        }).toList(),
                        underline: SizedBox(),
                        iconEnabledColor: Kcolor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextField(
                    controller: testTitlecontroller,
                    decoration: InputDecoration(
                      hintText: 'Test Title',
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10), // إبعاد النص عن الحواف
                    ),
                    cursorColor: Kcolor,
                    style: TextStyle(color: Kcolor),
                    onChanged: (value) {
                      setState(() {
                        testTitle = value;
                      });
                    },
                  ),
                ),
              ),
              ...questionContainers,
              if (selectedNumber != null && selectedNumber! > 0)
                ElevatedButton(
                  onPressed: () {
                    create();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Kcolor,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Create", style: TextStyle(color: Colors.black)),
                      SizedBox(width: 5),
                      Icon(Icons.edit_note_outlined, color: Colors.white)
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchCourses() async {
    final response = await http.get(
      Uri.parse('$baseurl'+'Quiz/getmycourses'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        Courses = jsonDecode(response.body);
        CoursesItems = (Courses['data'] as List)
            .map((course) => DropdownMenuItem<int>(
          value: course['id'],
          child: Text(course['name']),
        ))
            .toList();
      });
    } else {
      print('Error fetching Courses');
    }
  }

  create() async {
    List<Map<String, dynamic>> questions = [];

    for (int i = 0; i < selectedNumber!; i++) {
      TextEditingController questionController = questionContainers[i].questionController;
      List<Map<String, dynamic>> answers = [];

      bool hasCorrectAnswer = false;

      for (int j = 0; j < 3; j++) {
        TextEditingController answerController = questionContainers[i].answerControllers[j];
        bool isTrue = questionContainers[i].selectedValues[j] ?? false;

        if (isTrue) {
          if (hasCorrectAnswer) {
            Get.snackbar('Error', 'Question $i: Cannot have multiple correct answers', backgroundColor: Colors.black, colorText: Colors.white);
            return;
          }
          hasCorrectAnswer = true;
        }

        if (answerController.text.trim().isEmpty) {
          Get.snackbar('Error', 'Answer $j for Question $i cannot be empty', backgroundColor: Colors.black, colorText: Colors.white);
          return;
        }

        answers.add({
          'text': answerController.text,
          'is_correct': isTrue ? 1 : 0,
        });
      }

      if (questionController.text.trim().isEmpty) {
        Get.snackbar('Error', 'Question $i cannot be empty', backgroundColor: Colors.black, colorText: Colors.white);
        return;
      }

      questions.add({
        'text': questionController.text,
        'answers': answers,
      });
    }

    Map<String, dynamic> body = {
      'title': testTitlecontroller.text,
      'question_number': selectedNumber,
      'course_id': selectedCoursesId,
      'questions': questions,
    };

    print('Request Body: $body'); // Debugging: print the request body
    String encodedBody = jsonEncode(body);
    print('Encoded Body: $encodedBody'); // Debugging: print the encoded body

    try {
      final response = await http.post(
        Uri.parse('$baseurl'+'Quiz/createquiz'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: encodedBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> res = jsonDecode(response.body);
        print(res); // Debugging: check server response

        if (res['status'] == 'Success') {
          Get.snackbar('Success', 'Quiz created successfully', backgroundColor: Kcolor, colorText: Colors.white);
          Get.to(QuizList());
        } else {
          Get.snackbar('Error', 'Failed to create quiz', backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar('Error', 'Failed to create quiz', backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('Error: $e'); // Debugging: log error for investigation
      Get.snackbar('Error', 'Failed to create quiz', backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}

class QuestionContainer extends StatefulWidget {
  final int index;
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> answerControllers = List.generate(3, (index) => TextEditingController());
  final List<bool?> selectedValues = [null, null, null];

  QuestionContainer({required this.index});

  @override
  _QuestionContainerState createState() => _QuestionContainerState();
}

class _QuestionContainerState extends State<QuestionContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/test.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 295,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildBlurredTextField('Title Question', widget.questionController),
                  for (int i = 0; i < widget.answerControllers.length; i++)
                    buildBlurredTextFieldWithDropdown('Title answer', widget.answerControllers[i], i),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBlurredTextField(String hintText, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Container(
            width: 350,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10), // إبعاد النص عن الحواف
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBlurredTextFieldWithDropdown(String hintText, TextEditingController controller, int answerIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Container(
            width: 350,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10), // إبعاد النص عن الحواف
                    ),
                  ),
                ),
                DropdownButton<bool>(
                  value: widget.selectedValues[answerIndex],
                  items: [
                    DropdownMenuItem<bool>(
                      value: true,
                      child: Icon(Icons.check_circle, color: Colors.green),
                    ),
                    DropdownMenuItem<bool>(
                      value: false,
                      child: Icon(Icons.cancel, color: Colors.red),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      widget.selectedValues[answerIndex] = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

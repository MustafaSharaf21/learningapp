import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import '../../core/constants.dart';

class CreatQuestion extends StatefulWidget {
 // static String id = " HomePage";
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<CreatQuestion> {
  String? selectedSpecialization;
  int? selectedNumber;
  List<Widget> questionContainers = [];
  String? testTitle;

  final List<String> specializations = [
    ' 1  UI/UX',
    ' 2  CSS',
    ' 3  HTML',
  ];

  final List<int> numbers = List.generate(11, (index) => index + 5);

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
                      decoration: BoxDecoration(
                        border: Border.all(color: Kcolor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Specialty", style: TextStyle(color: Colors.black)),
                        ),
                        value: selectedSpecialization,
                        onChanged: (newValue) {
                          setState(() {
                            selectedSpecialization = newValue;
                          });
                        },
                        items: specializations.map((specialization) {
                          return DropdownMenuItem<String>(
                            value: specialization,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(specialization),
                            ),
                          );
                        }).toList(),
                        underline: SizedBox(),
                        iconEnabledColor: Kcolor,
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
                    decoration: InputDecoration(
                      hintText: 'Test Title',
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
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
}

class QuestionContainer extends StatefulWidget {
  final int index;

  QuestionContainer({required this.index});

  @override
  _QuestionContainerState createState() => _QuestionContainerState();
}

class _QuestionContainerState extends State<QuestionContainer> {
  List<bool?> selectedValues = [null, null, null];

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
                  buildBlurredTextField('Title Question ${widget.index + 1}'),
                  for (int i = 0; i < 3; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: buildBlurredTextField('answer ${i + 1}'),
                          ),
                          SizedBox(width: 8),
                          DropdownButton<bool>(
                            value: selectedValues[i],
                            icon: Icon(Icons.arrow_drop_down, color: Kcolor),
                            onChanged: (newValue) {
                              setState(() {
                                if (newValue == true && selectedValues.contains(true)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('لا يمكن اختيار أكثر من إجابة صحيحة'),
                                    ),
                                  );
                                  return;
                                }
                                selectedValues[i] = newValue;
                              });
                              if (selectedValues.every((element) => element == false)) {
                                setState(() {
                                  selectedValues[i] = null;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('يجب أن يكون هناك إجابة صحيحة واحدة على الأقل'),
                                  ),
                                );
                              }
                            },
                            items: [
                              DropdownMenuItem<bool>(
                                value: true,
                                child: Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Kcolor),
                                    SizedBox(width: 8),
                                    Text(''),
                                  ],
                                ),
                              ),
                              DropdownMenuItem<bool>(
                                value: false,
                                child: Row(
                                  children: [
                                    Icon(Icons.cancel, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text(''),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBlurredTextField(String hintText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.black, fontFamily: 'Pacifico'),
              ),
              cursorColor: Kcolor,
              style: TextStyle(color: Kcolor),
            ),
          ),
        ),
      ),
    );
  }
}

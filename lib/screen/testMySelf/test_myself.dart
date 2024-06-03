import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants.dart';
import 'creat_questions.dart';
import 'quiz_list.dart';
class TestMySelf extends StatefulWidget {
  static String id = " TestMySelf";
  const TestMySelf({super.key});

  @override
  State<TestMySelf> createState() => _TestMySelfState();
}

class _TestMySelfState extends State<TestMySelf> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(backgroundColor: Kcolor,
      title: Text('Test My Self'),
      actions: [Container(child: IconButton(icon:Icon(Icons.add_circle_outline),onPressed: (){
        Get.to(()=>CreatQuestion());
      },),),]

    ),
      body:  QuizList(),
    );
  }
}

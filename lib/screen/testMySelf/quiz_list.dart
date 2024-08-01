import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learningapp/core/constants.dart';
import '../../data/http.dart';
import 'quiz_page.dart';
import 'package:http/http.dart' as http;
class Quiz {
  final int id;
  final String title;
  final String author;
  final int questionsCount;

  Quiz(this.id, this.title, this.author, this.questionsCount);
}

class QuizList extends StatefulWidget {
  @override
  State<QuizList> createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  List<dynamic> quizes = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuizes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Quiz List'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: quizes.length,
          itemBuilder: (context, index) {
            final quiz = quizes[index];
            return Container(
              margin: EdgeInsets.only(left: 8.0,bottom: 12.0,right: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Kcolor, width: 2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(quizes[index]['title']),
               // subtitle: Text('Author: ${quiz.author}'),
                trailing: Text('Questions: ${quizes[index]['question_number']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizPage( id: quizes[index]['id'],),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> fetchQuizes() async {
    try {
      final response = await http.get(
        Uri.parse('$baseurl'+'Quiz/getquizzes'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        setState(() {
          quizes = data;
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

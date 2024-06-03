import 'package:flutter/material.dart';
import 'package:learningapp/core/constants.dart';
import 'quiz_page.dart';

class Quiz {
  final int id;
  final String title;
  final String author;
  final int questionsCount;

  Quiz(this.id, this.title, this.author, this.questionsCount);
}

class QuizList extends StatelessWidget {
  final List<Quiz> quizzes = [
    Quiz(1, "Quiz 1", "Author 1", 5),
    Quiz(2, "Quiz 2", "Author 2", 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // title: Text('Quiz List'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: quizzes.length,
          itemBuilder: (context, index) {
            final quiz = quizzes[index];
            return Container(
              margin: EdgeInsets.only(left: 8.0,bottom: 12.0,right: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Kcolor, width: 2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(quiz.title),
                subtitle: Text('Author: ${quiz.author}'),
                trailing: Text('Questions: ${quiz.questionsCount}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizPage(quiz: quiz),
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
}

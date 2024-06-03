import 'package:flutter/material.dart';
import 'result_page.dart';
import 'question_widget.dart';
import 'quiz_list.dart';

class QuizPage extends StatefulWidget {
  final Quiz quiz;

  QuizPage({required this.quiz});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;

  final List<Map<String, Object>> questionsData = [
    {
      'question': "What is 2 + 2?",
      'answers': ["3", "4", "5"],
      'correct': 1,
    },
    {
      'question': "What is the capital of France?",
      'answers': ["London", "Berlin", "Paris"],
      'correct': 2,
    },

  ];

  void handleAnswer(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        correctAnswers++;
      } else {
        wrongAnswers++;
      }

      if (currentQuestionIndex < questionsData.length - 1) {
        currentQuestionIndex++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              correctAnswers: correctAnswers,
              totalQuestions: questionsData.length,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Correct: $correctAnswers',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600,fontSize: 17.5),),
                Text('Wrong: $wrongAnswers',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600,fontSize: 17.5),),
              ],
            ),
          ),
          Expanded(
            child: QuestionWidget(
              data: questionsData[currentQuestionIndex],
              onAnswer: handleAnswer,
            ),
          ),
        ],
      ),
    );
  }
}

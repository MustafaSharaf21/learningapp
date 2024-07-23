import 'package:flutter/material.dart';
import '../../data/http.dart';
import 'result_page.dart';
import 'question_widget.dart';
import 'dart:convert';

class QuizPage extends StatefulWidget {
  final int id;

  QuizPage({required this.id});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  List<Map<String, dynamic>> questionsData = []; // استخدام dynamic بدلاً من Object
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      var response = await HttpHelper.gettData(url: 'Quiz/getquestions/${widget.id}');
      var responseBody = jsonDecode(response.body);

      if (responseBody['status'] == 'Success') {
        List<dynamic> questionsJson = responseBody['data']['original']['questions'];
        setState(() {
          questionsData = questionsJson.map((question) {
            List<String> answers = [];
            int correctAnswerIndex = 0;

            List<dynamic> answersJson = question['answers'];
            answersJson.asMap().forEach((index, answer) {
              answers.add(answer['text']);
              if (answer['is_correct'] == 1) {
                correctAnswerIndex = index;
              }
            });

            return {
              'question': question['text'],
              'answers': answers,
              'is_correct': correctAnswerIndex,
            }; // لا حاجة لتحويل النوع هنا
          }).toList();

          isLoading = false;
        });

      }
    } catch (error) {
      print('Error fetching questions: $error');
    }
  }

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
              quizId: widget.id, // تمرير الـ quizId هنا
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
        title: Text('Quiz'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Correct: $correctAnswers',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 17.5),
                ),
                Text(
                  'Wrong: $wrongAnswers',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 17.5),
                ),
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

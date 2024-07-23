import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http; // تأكد من إضافة مكتبة http
import 'dart:math';
import 'package:learningapp/core/constants.dart';
import '../../data/http.dart'; // استدعاء HttpHelper

class ResultPage extends StatefulWidget {
  final int correctAnswers;
  final int totalQuestions;
  final int quizId; // أضف هذا إذا كنت تحتاج للـ quizId

  ResultPage({required this.correctAnswers, required this.totalQuestions, required this.quizId}); // أضف الـ quizId هنا

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: (widget.correctAnswers / widget.totalQuestions) * 100)
        .animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward().then((value) {
      // استدعاء دالة إرسال النتيجة
      sendResult(widget.quizId, (widget.correctAnswers / widget.totalQuestions * 100).toInt());

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('!تهانينا', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: Text('.لقد أكملت الاختبار'),
          actions: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/High five-bro.png',
                      width: 165,
                      height: 125,
                    ),
                    SizedBox(width: 2),
                    Text('Finish'),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<void> sendResult(int quizId, int finalMark) async {
    try {
      var response = await HttpHelper.postData(
        url: 'Quiz/certification',
        body: {
          'quiz_id': quizId.toString(),
          'final_mark': finalMark.toString(),
        },
      );

      if (response.statusCode == 200) {
        print('Result sent successfully');
      } else {
        print('Failed to send result');
      }
    } catch (error) {
      print('Error sending result: $error');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        margin: EdgeInsets.only(top: 89),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Correct Answers: ${widget.correctAnswers} out of ${widget.totalQuestions}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Container(
              width: 100,
              height: 100,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: _animation.value / 100,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Kcolor),
                  ),
                  Center(
                    child: Text(
                      '${_animation.value.toStringAsFixed(1)}%',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

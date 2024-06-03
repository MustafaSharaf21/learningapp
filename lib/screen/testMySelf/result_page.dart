import 'package:flutter/material.dart';
import 'dart:math';

import 'package:learningapp/core/constants.dart';

class ResultPage extends StatefulWidget {
  final int correctAnswers;
  final int totalQuestions;

  ResultPage({required this.correctAnswers, required this.totalQuestions});

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
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('!تهانينا',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
                    //Spacer(),
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
      body: Container(height: MediaQuery.sizeOf(context).height,
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

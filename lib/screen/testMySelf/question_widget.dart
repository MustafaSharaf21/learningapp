import 'package:flutter/material.dart';

class QuestionWidget extends StatefulWidget {
  final Map<String,dynamic > data;
  final Function(bool) onAnswer;

  QuestionWidget({required this.data, required this.onAnswer});

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int? selectedAnswer;

  @override
  void initState() {
    super.initState();
    selectedAnswer = null; // Initialize selectedAnswer as null when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    List<String> answers = List<String>.from(widget.data['answers'] as List);
    int correctAnswerIndex = widget.data['is_correct'] as int;
    String questionText = widget.data['question'] as String;
    String imageUrl = 'assets/images/Thinking face-bro.png'; // Replace with your image path

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            questionText,
            style: TextStyle(fontSize: 24),
          ),
        ),
        Image.asset(
          imageUrl,
          height: 150, // Adjust height as needed
          width: 150, // Adjust width as needed
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: List.generate(answers.length, (index) {
                  return ListTile(
                    title: Text(answers[index]),
                    leading: Radio<int>(
                      value: index,
                      groupValue: selectedAnswer,
                      onChanged: (int? value) {
                        setState(() {
                          selectedAnswer = value;
                          widget.onAnswer(value == correctAnswerIndex);
                        });
                      },
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void didUpdateWidget(covariant QuestionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset selectedAnswer to null when the widget updates with new data
    if (widget.data != oldWidget.data) {
      setState(() {
        selectedAnswer = null;
      });
    }
  }
}

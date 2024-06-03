import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final Map<String, Object> data;
  final Function(bool) onAnswer;

  QuestionWidget({required this.data, required this.onAnswer});

  @override
  Widget build(BuildContext context) {
    List<String> answers = data['answers'] as List<String>;
    int correctAnswerIndex = data['correct'] as int;
    int? selectedAnswer;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            data['question'] as String,
            style: TextStyle(fontSize: 24),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset('assets/images/Thinking face-bro.png', height: 150, width: 150),
              ),
            ),
            Expanded(
              child: Column(
                children: List.generate(answers.length, (index) {
                  return ListTile(
                    title: Text(answers[index]),
                    leading: Radio<int>(
                      value: index,
                      groupValue: selectedAnswer,
                      onChanged: (int? value) {
                        selectedAnswer = value;
                        onAnswer(value == correctAnswerIndex);
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
}

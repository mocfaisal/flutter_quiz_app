import 'package:flutter/material.dart';
import 'answer.dart';

class Question extends StatelessWidget {
  final String questionText;
  final List<String> answers;
  final Function answerQuestion;

  Question({
    required this.questionText,
    required this.answers,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          questionText,
          style: TextStyle(fontSize: 20),
        ),
        ...answers.map((answer) {
          return Answer(
            answerText: answer,
            selectHandler: () => answerQuestion(answer),
          );
        }).toList(),
      ],
    );
  }
}

import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'question.dart';
import 'result.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int _questionIndex = 0;
  int _totalQuestion = 0;
  int _totalScore = 0;
  List<Map<String, dynamic>> _questions = [];

  Future<void> _loadQuestions() async {
    try {
      String jsonString = await rootBundle.loadString('listQuestion.json');
      // print('Loaded JSON data: $jsonString');
      List<dynamic> jsonData = json.decode(jsonString);
      // print('Decoded JSON data: $jsonData');

      // Clear existing questions
      _questions.clear();

      for (var questionData in jsonData) {
        List<String> answers = List<String>.from(questionData['answers']);
        Map<String, dynamic> question = {
          'questionText': questionData['questionText'],
          'answers': answers,
          'correctAnswer': questionData['correctAnswer'],
        };
        _questions.add(question);
      }

      _totalQuestion = _questions.length;
      _shuffleQuestions();
    } catch (e) {
      print('Error loading questions: $e');
    }
  }

  void _answerQuestion(String answer) {
    setState(() {
      if (_questions[_questionIndex]['correctAnswer'] == answer) {
        _totalScore++;
      }

      _questionIndex++;
    });
  }

  void _shuffleQuestions() {
    // Shuffle Questions & Answer
    setState(() {
      _questions.forEach((data) {
        _questions.shuffle(Random());
        _questions.forEach((question) {
          question['answers'].shuffle(Random());
        });
      });
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
    _shuffleQuestions();
  }

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Questions Left: ${_questions.length - _questionIndex}',
            style: TextStyle(fontSize: 18),
          ),
        ),
        _questionIndex < _questions.length
            ? Question(
                questionText: _questions[_questionIndex]['questionText'],
                answers: _questions[_questionIndex]['answers'],
                answerQuestion: _answerQuestion,
              )
            : Results(_totalQuestion, _totalScore, _resetQuiz),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Mochammad Faisal',
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }
}

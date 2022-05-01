import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _questionIndex = 0;
  int _totalScore = 0;

  List<Map<String, dynamic>> ques_ans = [
    {
      "question": "What's your favorite color?",
      "answers": [
        {"text": "Red", "score": 5},
        {"text": "Green", "score": 30},
        {"text": "Blue", "score": 10}
      ],
    },
    {
      "question": "What's your favorite animal?",
      "answers": [
        {"text": "Dog", "score": 30},
        {"text": "Cat", "score": 5},
        {"text": "Rabbit", "score": 10}
      ],
    },
    {
      "question": "What's your favorite food?",
      "answers": [
        {"text": "Pizza", "score": 30},
        {"text": "Burger", "score": 5},
        {"text": "Pasta", "score": 10}
      ],
    },
  ];

  void _answerChosen(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex = (_questionIndex + 1);
    });
  }

  void _restartQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text("My first app")),
          body: _questionIndex < ques_ans.length
              ? Quiz(
                  answerChosen: _answerChosen,
                  questionIndex: _questionIndex,
                  questions: ques_ans,
                )
              : Result(_totalScore, _restartQuiz)),
    );
  }
}

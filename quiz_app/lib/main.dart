import 'package:flutter/material.dart';
import 'package:quiz_app/answer.dart';
import './Question.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _questionIndex = 0;

  List<Map<String, dynamic>> ques_ans = [
    {
      "question": "What's your favorite color?",
      "answers": ["Red", "Green", "Blue"],
    },
    {
      "question": "What's your favorite animal?",
      "answers": ["Dog", "Cat", "Bird"]
    },
    {
      "question": "What's your favorite food?",
      "answers": ["Pizza", "Burger", "Pasta"]
    },
  ];

  void _answerChosen() {
    setState(() {
      _questionIndex = (_questionIndex + 1) % ques_ans.length;
    });
    print('Answer chosen!');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text("My first app")),
          body: Column(children: [
            Question(ques_ans[_questionIndex]["question"]),
            Answer(_answerChosen, ques_ans[_questionIndex]["answers"][0]),
            Answer(_answerChosen, ques_ans[_questionIndex]["answers"][1]),
            Answer(_answerChosen, ques_ans[_questionIndex]["answers"][2]),
          ])),
    );
  }
}

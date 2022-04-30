import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, dynamic>> questions;
  final int questionIndex;
  final Function answerChosen;

  Quiz(
      {required this.questions,
      required this.questionIndex,
      required this.answerChosen});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Question(questions[questionIndex]["question"] as String),
      Answer(
          () => answerChosen(questions[questionIndex]["answers"][0]["score"]),
          (questions[questionIndex]["answers"][0]["text"])),
      Answer(
          () => answerChosen(questions[questionIndex]["answers"][1]["score"]),
          (questions[questionIndex]["answers"][1]["text"])),
      Answer(
          () => answerChosen(questions[questionIndex]["answers"][1]["score"]),
          (questions[questionIndex]["answers"][2]["text"])),
    ]);
  }
}

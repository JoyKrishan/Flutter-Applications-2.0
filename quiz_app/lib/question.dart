import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  // final is runtime constant value
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(questionText,
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 30,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center),
    );
  }
}

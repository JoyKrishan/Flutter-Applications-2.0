import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int _totalScore;
  final VoidCallback _restartQuiz;

  Result(this._totalScore, this._restartQuiz);

  String getResult(int totalScore) {
    if (totalScore < 10) {
      return ("You are a bad person");
    } else if (totalScore < 20) {
      return "You are a good person";
    } else if (totalScore < 30) {
      return "You are a great person";
    } else {
      return "You are a super person";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              getResult(_totalScore),
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(onPressed: _restartQuiz, child: Text("Restart Quiz"))
        ],
      ),
    );
  }
}

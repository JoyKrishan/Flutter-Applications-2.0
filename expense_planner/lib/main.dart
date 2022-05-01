import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Flutter App"),
      ),
      body: Column(children: [
        Container(
          width: double.infinity,
          child: Card(
            color: Colors.blue,
            child: Text("Hello"),
          ),
        ),
        Card(
          child: Text("World"),
        )
      ]),
    );
  }
}

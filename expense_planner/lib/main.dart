import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/new_transactions.dart';
import 'package:expense_planner/widgets/user_transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'widgets/transactions_list.dart';

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
            elevation: 10,
            color: Colors.blue,
            child: Text("Hello"),
          ),
        ),
        // text fields card
        UserTransactions()
      ]),
    );
  }
}

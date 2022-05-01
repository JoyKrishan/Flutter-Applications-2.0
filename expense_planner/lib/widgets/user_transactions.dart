import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'new_transactions.dart';
import 'transactions_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
        id: "124fd", title: "Shoes", amount: 83.44, date: DateTime.now()),
    Transaction(
        id: "124fe", title: "Shirt", amount: 70.44, date: DateTime.now()),
  ];

  void _addTransactions(String title, double amount) {
    Transaction newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());
    setState(() {
      _transactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransactions(_addTransactions),
        //Listview of the transactions
        TranstionsList(_transactions)
      ],
    );
  }
}

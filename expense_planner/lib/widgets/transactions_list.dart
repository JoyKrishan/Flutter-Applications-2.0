import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TranstionsList extends StatelessWidget {
  final List<Transaction> transactions;

  TranstionsList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: ListView.builder(
          itemBuilder: (cxt, idx) {
            return Card(
                child: Row(
              children: [
                // dollar container
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: Colors.purple,
                            style: BorderStyle.solid)),
                    child: Text(
                      "\$${transactions[idx].amount}",
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Transaction title
                    Text(
                      transactions[idx].title,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    // Transaction date
                    Text(
                      DateFormat.yMMMd().format(transactions[idx].date),
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 104, 103, 103)),
                    )
                  ],
                )
              ],
            ));
          },
          itemCount: transactions.length,
        ));
  }
}

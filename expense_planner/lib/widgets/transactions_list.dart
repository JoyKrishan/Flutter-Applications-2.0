import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'transaction_item.dart';

class TranstionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTx;

  const TranstionsList(this.transactions, this.removeTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: transactions.isEmpty
            ? LayoutBuilder(
                builder: ((context, constraints) => Column(children: [
                      Text(
                        "No Transactions added yet!",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.1,
                      ),
                      Container(
                          height: constraints.maxHeight * 0.7,
                          child: Image.asset("assets/images/waiting.png")),
                    ])))
            : ListView.builder(
                itemBuilder: (cxt, idx) {
                  return TransactionItem(
                      transaction: transactions[idx], removeTx: removeTx);
                },
                itemCount: transactions.length,
              ));
  }
}


// Card(
//                       child: Row(
//                     children: [
//                       dollar container
//                       Container(
//                           margin: EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 15),
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                   width: 2,
//                                   color: Theme.of(context).primaryColor,
//                                   style: BorderStyle.solid)),
//                           child: Text(
//                             "\$${transactions[idx].amount.toStringAsFixed(2)}",
//                             style: TextStyle(
//                                 color: Theme.of(context).primaryColor,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold),
//                           )),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Transaction title
//                           Text(
//                             transactions[idx].title,
//                             style: Theme.of(context).textTheme.titleMedium,
//                           ),
//                           Transaction date
//                           Text(
//                             DateFormat.yMMMd().format(transactions[idx].date),
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 color: Color.fromARGB(255, 104, 103, 103)),
//                           )
//                         ],
//                       )
//                     ],
//                   ));
                

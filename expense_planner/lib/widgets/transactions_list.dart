import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TranstionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTx;

  TranstionsList(this.transactions, this.removeTx);

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
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(10),
                    elevation: 6,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                            child: Text(
                              "\$${transactions[idx].amount.toStringAsFixed(0)}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      trailing: MediaQuery.of(context).size.width > 500
                          ? FlatButton.icon(
                              onPressed: () => removeTx(transactions[idx].id),
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).errorColor,
                              ),
                              label: Text(
                                "Delete",
                                style: TextStyle(
                                    color: Theme.of(context).errorColor),
                              ))
                          : IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).errorColor,
                              ),
                              onPressed: () => removeTx(transactions[idx].id),
                            ),
                      title: Text(
                        transactions[idx].title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[idx].date),
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 104, 103, 103)),
                      ),
                    ),
                  );
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
                

import 'dart:math';

import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.removeTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function removeTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;

  @override
  void initState() {
    super.initState();
    const List<Color> cirColors = [
      Colors.red,
      Colors.black,
      Colors.brown,
      Colors.indigo
    ];
    _bgColor = cirColors[Random().nextInt(4)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 6,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                "\$${widget.transaction.amount.toStringAsFixed(0)}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 500
            ? FlatButton.icon(
                onPressed: () => widget.removeTx(widget.transaction.id),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: Text(
                  "Delete",
                  style: TextStyle(color: Theme.of(context).errorColor),
                ))
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () => widget.removeTx(widget.transaction.id),
              ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
          style: TextStyle(
              fontSize: 15, color: Color.fromARGB(255, 104, 103, 103)),
        ),
      ),
    );
  }
}

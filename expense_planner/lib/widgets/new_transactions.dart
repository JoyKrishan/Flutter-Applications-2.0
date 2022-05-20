import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class NewTransactions extends StatefulWidget {
  final Function addTrans;

  NewTransactions(this.addTrans) {
    print("Constructor NewTransactions");
  }

  @override
  // ignore: no_logic_in_create_state
  State<NewTransactions> createState() {
    print("Create state _NewTransactionState");
    return _NewTransactionsState();
  }
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  _NewTransactionsState() {
    print("Constructor of Transaction State");
  }

  @override
  void initState() {
    print("InitState of NewTransactionState");
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransactions oldWidget) {
    print("WidgetUpdate of NewTransactionState");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print("Dispose of NewTransactionState");
    super.dispose();
  }

  void _submitData() {
    final txTitle = titleController.text;
    final txAmount = amountController.text.isEmpty
        ? null
        : double.parse(amountController.text);

    if (txTitle.isEmpty || txAmount == null || _selectedDate == null) {
      return;
    }

    widget.addTrans(txTitle, txAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          margin: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Row(children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? "No Date Choosen!"
                        : "Picked Date: ${DateFormat.yMd().format(_selectedDate!)}",
                  ),
                ),
                FlatButton(
                    onPressed: _pickDate,
                    highlightColor: Theme.of(context).primaryColor,
                    focusColor: Theme.of(context).primaryColor,
                    hoverColor: Theme.of(context).primaryColor,
                    child: Text(
                      "Choose Date",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ))
              ]),
              RaisedButton(
                onPressed: _submitData,
                child: Container(child: Text("Add Transaction")),
                textColor: Theme.of(context).textTheme.button!.color,
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

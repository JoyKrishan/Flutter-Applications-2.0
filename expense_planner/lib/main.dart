import 'package:expense_planner/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/transaction.dart';
import 'widgets/new_transactions.dart';
import 'widgets/transactions_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          textTheme: ThemeData.light()
              .textTheme
              .copyWith(button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20))),
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final _isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;
  final List<Transaction> _transactions = [];
  late final appbar = AppBar(
    actions: [
      IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add))
    ],
    title: Text("Expense Planner"),
  );

  bool _showChart = true;

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransactions(String title, double amount, DateTime chosenDate) {
    Transaction newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chosenDate);
    setState(() {
      _transactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext cxt) {
    showModalBottomSheet(
        context: cxt,
        builder: (bcxt) {
          return NewTransactions(_addTransactions);
        });
  }

  void _removeTransactions(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar,
        body: SingleChildScrollView(
          child: Column(children: [
            if (_isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart "),
                  Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      })
                ],
              ),
            if (!_isLandscape)
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(_transactions)),
            if (!_isLandscape)
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.7,
                  child:
                      TranstionsList(_recentTransactions, _removeTransactions)),
            if (_isLandscape)
              _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appbar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(_transactions))
                  : Container(
                      height: (MediaQuery.of(context).size.height -
                              appbar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: TranstionsList(
                          _recentTransactions, _removeTransactions)),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}

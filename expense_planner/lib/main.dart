import 'dart:io';

import 'package:expense_planner/widgets/chart.dart';
import 'package:flutter/material.dart';
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
  final List<Transaction> _transactions = [];

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

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Show Chart "),
          Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_transactions))
          : txListWidget,
    ];
  }

  List<Widget> _buildPotraitContent(
      MediaQueryData mediaQuery, AppBar appbar, Widget txListWidget) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appbar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(_transactions)),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar = AppBar(
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add))
      ],
      title: Text("Expense Planner"),
    );
    final txListWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TranstionsList(_recentTransactions, _removeTransactions));
    return Scaffold(
        appBar: appbar,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              if (_isLandscape)
                ..._buildLandscapeContent(mediaQuery, appbar, txListWidget),
              if (!_isLandscape)
                ..._buildPotraitContent(mediaQuery, appbar, txListWidget)
            ]),
          ),
        ),
        floatingActionButton: Platform.isIOS
            ? Container()
            : FloatingActionButton(
                onPressed: () => _startAddNewTransaction(context),
                child: Icon(Icons.add),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}

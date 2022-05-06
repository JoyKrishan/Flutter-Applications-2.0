import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chartBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get chartItems {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        final date = recentTransactions[i].date;
        if (date.day == weekDay.day &&
            date.month == weekDay.month &&
            date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'weekDay': DateFormat('EEEE').format(weekDay).substring(0, 2),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return chartItems.fold(
        0.0, (sum, element) => sum + (element['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: chartItems
                .map((tx) => Flexible(
                      fit: FlexFit.tight,
                      child: ChartBar(
                          tx['weekDay'] as String,
                          tx['amount'] as double,
                          tx['amount'] == 0.0
                              ? 0.0
                              : (tx['amount'] as double) / maxSpending),
                    ))
                .toList()),
      ),
    );
  }
}

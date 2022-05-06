import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double totalAmount;
  final double totalPctAmount;

  ChartBar(this.label, this.totalAmount, this.totalPctAmount);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: ((ctx, constraints) => Column(
              children: [
                Container(
                    height: constraints.maxHeight * 0.1,
                    child: FittedBox(
                        child: Text("\$${totalAmount.toStringAsFixed(0)}"))),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Container(
                  height: constraints.maxHeight * 0.7,
                  width: 10,
                  child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 223, 222, 222),
                                border:
                                    Border.all(width: 1.0, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10))),
                        FractionallySizedBox(
                          heightFactor: totalPctAmount,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        )
                      ]),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Container(
                    height: constraints.maxHeight * 0.1, child: Text(label))
              ],
            )));
  }
}

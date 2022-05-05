import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double totalAmount;
  final double totalPctAmount;

  ChartBar(this.label, this.totalAmount, this.totalPctAmount);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 10,
            child:
                FittedBox(child: Text("\$${totalAmount.toStringAsFixed(0)}"))),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(children: [
            Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 223, 222, 222),
                    border: Border.all(width: 1.0, color: Colors.grey),
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
          height: 4,
        ),
        Text(label)
      ],
    );
  }
}

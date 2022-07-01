import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/order.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem orderData;
  OrderItem({required this.orderData});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        child: ListTile(
          title: Text("\$${widget.orderData.price}"),
          subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.orderData.dtime)),
          trailing: IconButton(
            icon:
                Icon(expanded == false ? Icons.expand_more : Icons.expand_less),
            onPressed: () {
              setState(() {
                expanded = !expanded;
              });
            },
          ),
        ),
      ),
      if (expanded)
        Container(
          height: min(widget.orderData.items.length * 20 + 100.0, 180.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 225, 223, 223)),
          child: ListView(
            children: widget.orderData.items
                .map((items) => ListTile(
                      title: Text(items.title),
                      subtitle: Text("\$${items.price}"),
                      trailing: Text("${items.quantity}x"),
                    ))
                .toList(),
          ),
        ),
    ]);
  }
}

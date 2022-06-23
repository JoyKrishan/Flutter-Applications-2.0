import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Text(title),
          subtitle: Text('Total: ${price * quantity}'),
          trailing: Text('${quantity}x'),
          leading: CircleAvatar(
            child: FittedBox(
                child: Padding(
                    padding: EdgeInsets.all(5), child: Text('\$${price}'))),
          ),
        ),
      ),
    );
  }
}

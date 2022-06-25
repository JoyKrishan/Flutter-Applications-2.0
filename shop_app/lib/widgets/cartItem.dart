import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart' show Cart;

class CartItem extends StatelessWidget {
  final String productId;
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.productId,
      required this.id,
      required this.title,
      required this.quantity,
      required this.price});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(id),
      onDismissed: (direction) {
        cart.removeItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Are you sure?"),
                content: Text("Do you want to delete this item from the cart?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        return Navigator.of(context).pop(false);
                      },
                      child: Text("No")),
                  TextButton(
                      onPressed: () {
                        return Navigator.of(context).pop(true);
                      },
                      child: Text("Yes"))
                ],
              );
            });
      },
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        child: const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).errorColor,
        ),
      ),
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            title: Text(title),
            subtitle: Text('Total: ${price * quantity}'),
            trailing: Text('${quantity}x'),
            leading: CircleAvatar(
              child: FittedBox(
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text('\$${price}'))),
            ),
          ),
        ),
      ),
    );
  }
}

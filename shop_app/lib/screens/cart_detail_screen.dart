import 'package:flutter/material.dart';

class CartDetailScreen extends StatelessWidget {
  static const routeName = "/cart-detail";

  const CartDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
        ),
        body: Center(child: Text("My Cart")));
  }
}

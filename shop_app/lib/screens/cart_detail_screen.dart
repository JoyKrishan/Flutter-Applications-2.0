import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cartItem.dart';

class CartDetailScreen extends StatelessWidget {
  static const routeName = "/cart-detail";

  const CartDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartItemList = cart.items.values.toList();
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Card(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Chip(
                        label: Text(
                          "\$${cart.totalAmount}",
                          style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .bodyMedium
                                ?.color,
                          ),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      TextButton(
                          onPressed: () {
                            Provider.of<Order>(context, listen: false)
                                .addOrderItem(
                                    cartItems: cartItemList,
                                    price: cart.totalAmount);
                            cart.clear();
                          },
                          child: Text(
                            'Order Now',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ))
                    ],
                  )),
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: ((context, i) => CartItem(
                  productId: cart.items.keys.toList()[i],
                  id: cartItemList[i].id,
                  title: cartItemList[i].title,
                  price: cartItemList[i].price,
                  quantity: cartItemList[i].quantity)),
              itemCount: cartItemList.length,
            )),
          ],
        ));
  }
}

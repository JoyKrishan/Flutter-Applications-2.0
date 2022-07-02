import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cartItem.dart';

class CartDetailScreen extends StatefulWidget {
  static const routeName = "/cart-detail";

  const CartDetailScreen({Key? key}) : super(key: key);

  @override
  State<CartDetailScreen> createState() => _CartDetailScreenState();
}

class _CartDetailScreenState extends State<CartDetailScreen> {
  bool isLoadingOrder = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartItemList = cart.items.values.toList();
    final scaffold = ScaffoldMessenger.of(context);
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
                      // if (cartItemList.isEmpty)
                      //   Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Text(
                      //       'Order Now',
                      //       style: TextStyle(
                      //           fontSize: 20,
                      //           fontWeight: FontWeight.bold,
                      //           color: Theme.of(context).primaryColor),
                      //     ),
                      //   )
                      // else
                      TextButton(
                          onPressed: cartItemList.isEmpty
                              ? null
                              : () async {
                                  setState(() {
                                    isLoadingOrder = true;
                                  });
                                  try {
                                    await Provider.of<Order>(context,
                                            listen: false)
                                        .addOrderItem(
                                            cartItems: cartItemList,
                                            price: cart.totalAmount);
                                    cart.clear();
                                  } catch (err) {
                                    scaffold.showSnackBar(const SnackBar(
                                        content:
                                            Text("Could not add the Order")));
                                  } finally {
                                    setState(() {
                                      isLoadingOrder = false;
                                    });
                                  }
                                },
                          child: isLoadingOrder
                              ? const CircularProgressIndicator()
                              : Text(
                                  'Order Now',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: cartItemList.isEmpty
                                          ? Colors.grey
                                          : Theme.of(context).primaryColor),
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

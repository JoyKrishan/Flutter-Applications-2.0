import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/widgets/drawer.dart';

import '../widgets/orderItem.dart' as ord;

class OrderScreen extends StatelessWidget {
  static const routeName = '/order-screen';

  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Order>(context).items;
    return Scaffold(
      appBar: AppBar(title: Text("Orders")),
      drawer: CustomDrawer(),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(children: [
          Expanded(
              child: ListView.builder(
            itemBuilder: ((context, i) => ord.OrderItem(orderData: orders[i])),
            itemCount: orders.length,
          )),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/widgets/drawer.dart';

import '../widgets/orderItem.dart' as ord;

class OrderScreen extends StatefulWidget {
  static const routeName = '/order-screen';

  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isLoading = false;
  bool errorLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      setState(() {
        isLoading = true;
      });
      try {
        await Provider.of<Order>(context, listen: false).setAndFetchOrders();
      } catch (e) {
        setState(() {
          errorLoading = true;
        });
      }
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Order>(context).items;
    return Scaffold(
      appBar: AppBar(title: Text("Orders")),
      drawer: const CustomDrawer(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorLoading
              ? const Center(
                  child: Text("Could not load products"),
                )
              : Container(
                  margin: EdgeInsets.all(10),
                  child: Column(children: [
                    Expanded(
                        child: ListView.builder(
                      itemBuilder: ((context, i) =>
                          ord.OrderItem(orderData: orders[i])),
                      itemCount: orders.length,
                    )),
                  ]),
                ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:shop_app/screens/user_product_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Drawer(
        child: Column(
          children: [
            AppBar(
              title: Text("Hello Joy!"),
              automaticallyImplyLeading: false,
            ),
            Divider(),
            ListTile(
              title: Text("Shop"),
              leading: Icon(Icons.shop),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, ProductOverviewScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              title: Text("Order"),
              leading: Icon(Icons.payment),
              onTap: () {
                Navigator.pushReplacementNamed(context, OrderScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              title: Text("Manage product"),
              leading: Icon(Icons.edit),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, UserProductScreen.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}

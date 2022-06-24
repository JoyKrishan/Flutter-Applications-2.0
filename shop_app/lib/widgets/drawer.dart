import 'package:flutter/material.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
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
                Navigator.pushNamed(context, ProductOverviewScreen.routeName);
              },
            ),
            ListTile(
              title: Text("Order"),
              leading: Icon(Icons.payment),
              onTap: () {
                Navigator.pushNamed(context, OrderScreen.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/order.dart';
import 'package:shop_app/models/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/cart_detail_screen.dart';
import 'package:shop_app/screens/order_screen.dart';

import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:shop_app/screens/user_product_screen.dart';

void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Order())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductOverviewScreen(),
        theme: ThemeData(
            primarySwatch: Colors.teal,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          ProductOverviewScreen.routeName: (context) => ProductOverviewScreen(),
          CartDetailScreen.routeName: (context) => CartDetailScreen(),
          OrderScreen.routeName: (context) => OrderScreen(),
          UserProductScreen.routeName: (context) => UserProductScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen()
        },
      ),
    );
  }
}

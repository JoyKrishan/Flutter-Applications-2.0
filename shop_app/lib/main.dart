import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/products.dart';
import 'package:shop_app/screens/cart_detail_screen.dart';

import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';

void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        home: ProductOverviewScreen(),
        theme: ThemeData(
            primarySwatch: Colors.amber,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          ProductOverviewScreen.routeName: (context) => ProductOverviewScreen(),
          CartDetailScreen.routeName: (context) => CartDetailScreen(),
        },
      ),
    );
  }
}

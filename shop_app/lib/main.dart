import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/auth_screen.dart';
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
    var curContext = context;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((ctx) => Auth())),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: (ctx) =>
                Products(Provider.of<Auth>(ctx, listen: false).token!, []),
            update: (ctx, auth, previousProducts) => Products(auth.token!,
                previousProducts == null ? [] : previousProducts.getItems)),
        ChangeNotifierProxyProvider<Auth, Order>(
          create: (ctx) =>
              Order(Provider.of<Auth>(ctx, listen: false).token!, []),
          update: (ctx, auth, prevOrder) =>
              Order(auth.token!, prevOrder == null ? [] : prevOrder.items),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
          theme: ThemeData(
              primarySwatch: Colors.teal,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato'),
          routes: {
            ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
            ProductOverviewScreen.routeName: (context) =>
                ProductOverviewScreen(),
            CartDetailScreen.routeName: (context) => CartDetailScreen(),
            OrderScreen.routeName: (context) => OrderScreen(),
            UserProductScreen.routeName: (context) => UserProductScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
            AuthScreen.routeName: (context) => AuthScreen()
          },
        ),
      ),
    );
  }
}

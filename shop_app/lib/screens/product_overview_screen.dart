import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/drawer.dart';

import '../widgets/products_grid.dart';
import '../screens/cart_detail_screen.dart';
import '../providers/cart.dart';

enum FilterOptions { favourites, all }

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = '/product-overview';

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavouritesOnly = false;
  bool didInit = false;
  bool isLoading = false;

  @override
  void initState() {
    //Future.delayed(Duration.zero).then((_) => Provider.of<Products>(context).loadProductFromServer());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    isLoading = true;
    if (!didInit) {
      Provider.of<Products>(context, listen: false)
          .loadProductFromServer()
          .catchError((err) {
        showDialog<Null>(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                content: Text("Could not load product from server"),
                actions: [
                  TextButton(
                      onPressed: () {
                        return Navigator.pop(ctx);
                      },
                      child: Text("Okay"))
                ],
              );
            });
      }).then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    didInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text("My Shop"),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) {
              return [
                const PopupMenuItem(
                  child: Text("Only Favourites"),
                  value: FilterOptions.favourites,
                ),
                const PopupMenuItem(
                  child: Text("All Items"),
                  value: FilterOptions.all,
                )
              ];
            },
            onSelected: (selectedVal) {
              if (selectedVal == FilterOptions.all) {
                setState(() {
                  _showFavouritesOnly = false;
                });
              } else {
                setState(() {
                  _showFavouritesOnly = true;
                });
              }
            },
            icon: const Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (context, cart, ch) =>
                Badge(child: ch!, value: cart.totalItem.toString()),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, CartDetailScreen.routeName);
              },
            ),
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showFavouritesOnly),
    );
  }
}

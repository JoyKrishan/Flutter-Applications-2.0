import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/widgets/badge.dart';

import '../widgets/products_grid.dart';

enum FilterOptions { favourites, all }

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = '/product-overview';

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavouritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Shop"),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  child: Text("Only Favourites"),
                  value: FilterOptions.favourites,
                ),
                PopupMenuItem(
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
            icon: Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (context, cart, ch) =>
                Badge(child: ch!, value: cart.totalItem.toString()),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: ProductsGrid(_showFavouritesOnly),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const ProductItem(
      {Key? key,
      required this.id,
      required this.imageUrl,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final scaffold = Scaffold.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProductDetailScreen.routeName,
                  arguments: product.id);
            },
            child: Image.network(imageUrl, fit: BoxFit.fill)),
        footer: GridTileBar(
          title: Text(title, textAlign: TextAlign.center),
          backgroundColor: Colors.black87,
          leading: IconButton(
              color: Theme.of(context).accentColor,
              onPressed: () {
                cart.addItem(product.id, product.title, product.price);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Added item to cart!"),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "UNDO",
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ));
              },
              icon: const Icon(Icons.shopping_cart)),
          // favourite icon
          trailing: Consumer<Product>(
            builder: (context, value, child) => IconButton(
              color: Colors.deepOrange,
              onPressed: () async {
                try {
                  await product.toggleIsFavourite();
                } catch (err) {
                  scaffold.removeCurrentSnackBar();
                  scaffold.showSnackBar(const SnackBar(
                      content: Text("Could not add to Favourites")));
                }
              },
              icon: Icon(
                  product.isFavourite ? Icons.favorite : Icons.favorite_border),
            ),
          ),
        ),
      ),
    );
  }
}

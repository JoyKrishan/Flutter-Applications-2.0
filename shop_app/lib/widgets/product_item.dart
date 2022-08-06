import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';

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
    final scaffold = ScaffoldMessenger.of(context);
    final token = Provider.of<Auth>(context, listen: false).token;
    final userID = Provider.of<Auth>(context, listen: false).userID;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProductDetailScreen.routeName,
                  arguments: product.id);
            },
            child: Hero(
              tag: product.id,
              child: FadeInImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.fill,
                placeholder: AssetImage('assets/images/placeholder.png'),
              ),
            )),
        footer: GridTileBar(
          title: Text(title, textAlign: TextAlign.center),
          backgroundColor: Colors.black87,
          leading: IconButton(
              color: Theme.of(context).accentColor,
              onPressed: () async {
                try {
                  await cart.addItem(product.id, product.title, product.price);
                  scaffold.clearSnackBars();
                  scaffold.showSnackBar(SnackBar(
                    content: Text("Added item to cart!"),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ));
                } catch (err) {
                  scaffold.showSnackBar(
                      const SnackBar(content: Text("Could not add to Cart")));
                }
              },
              icon: const Icon(Icons.shopping_cart)),
          // favourite icon
          trailing: Consumer<Product>(
            builder: (context, value, child) => IconButton(
              color: Colors.deepOrange,
              onPressed: () async {
                try {
                  await product.toggleIsFavourite(token!, userID!);
                } catch (err) {
                  scaffold.clearSnackBars();
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

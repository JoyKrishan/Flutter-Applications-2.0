import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

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
    final product = Provider.of<Product>(context);
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
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart)),
          // favourite icon
          trailing: IconButton(
            color: Theme.of(context).accentColor,
            onPressed: () {
              product.toggleIsFavourite();
            },
            icon: Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_border),
          ),
        ),
      ),
    );
  }
}
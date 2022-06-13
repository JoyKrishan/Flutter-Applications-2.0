import 'package:flutter/material.dart';
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProductDetailScreen.routeName,
                  arguments: id);
            },
            child: Image.network(imageUrl, fit: BoxFit.fill)),
        footer: GridTileBar(
          title: Text(title, textAlign: TextAlign.center),
          backgroundColor: Colors.black54,
          leading: IconButton(
              color: Theme.of(context).accentColor,
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart)),
          trailing: IconButton(
            color: Theme.of(context).accentColor,
            onPressed: () {},
            icon: const Icon(Icons.favorite),
          ),
        ),
      ),
    );
  }
}

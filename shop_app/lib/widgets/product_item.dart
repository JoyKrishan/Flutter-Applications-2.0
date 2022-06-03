import 'package:flutter/material.dart';

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
    return GridTile(
      child: Image.network(imageUrl, fit: BoxFit.fill),
      footer: GridTileBar(
        title: Text(title, textAlign: TextAlign.center),
        backgroundColor: Colors.black38,
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite),
        ),
      ),
    );
  }
}

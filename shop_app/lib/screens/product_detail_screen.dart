import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context)?.settings.arguments as String; // product ID
    final product =
        Provider.of<Products>(context, listen: false).getById(productId);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverLayoutBuilder(
            builder: ((ctx, constraints) {
              final scrolled = constraints.scrollOffset > 0;
              return SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.4,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Container(
                      color: scrolled
                          ? Theme.of(context).appBarTheme.color
                          : Colors.black54,
                      child: Text(
                        product.title,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    background: Container(
                      color: Colors.red,
                      child: Hero(
                        tag: product.id,
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ));
            }),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(
              height: 10,
            ),
            Text(
              "\$${product.price}",
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.description,
              softWrap: true,
              style: const TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 1000,
            )
          ]))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  bool _favouriteFilter;
  ProductsGrid(this._favouriteFilter);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = _favouriteFilter
        ? productsData.showFavouriteItems(_favouriteFilter)
        : productsData.getItems;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemBuilder: (cxt, i) {
        return ChangeNotifierProvider.value(
          value: products[i],
          child: ProductItem(
              id: products[i].id,
              imageUrl: products[i].imageUrl,
              title: products[i].title),
        );
      },
      itemCount: products.length,
    );
  }
}

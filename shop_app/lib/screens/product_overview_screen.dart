import 'package:flutter/material.dart';

import 'package:shop_app/models/product.dart';
import 'package:shop_app/widgets/product_item.dart';
import '../widgets/products_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  static const routeName = '/product-overview';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Shop")),
      body: ProductsGrid(),
    );
  }
}

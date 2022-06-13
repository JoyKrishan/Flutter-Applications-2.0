import 'package:flutter/material.dart';

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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/products.dart';
import 'package:shop_app/widgets/drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product-screen';

  const UserProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: ListView.builder(
          itemBuilder: (ctx, i) {
            return UserProductItem(
                title: productData.getItems[i].title,
                imgUrl: productData.getItems[i].imageUrl);
          },
          itemCount: productData.getItems.length,
        ),
      ),
    );
  }
}

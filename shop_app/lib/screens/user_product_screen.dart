import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product-screen';

  const UserProductScreen({Key? key}) : super(key: key);

  Future<void> refreshProducts(BuildContext context) async {
    return await Provider.of<Products>(context, listen: false)
        .loadProductFromServer(true);
  }

  @override
  Widget build(BuildContext context) {
    //final productData = Provider.of<Products>(context);
    print("rebuilding");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const CustomDrawer(),
      body: FutureBuilder(
        future: refreshProducts(context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () {
                      return refreshProducts(context);
                    },
                    child: Consumer<Products>(
                      builder: (context, productData, _) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: ListView.builder(
                          itemBuilder: (ctx, i) {
                            return UserProductItem(
                                id: productData.getItems[i].id,
                                title: productData.getItems[i].title,
                                imgUrl: productData.getItems[i].imageUrl);
                          },
                          itemCount: productData.getItems.length,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}

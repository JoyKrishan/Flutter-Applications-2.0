import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;

  UserProductItem(
      {required this.id, required this.title, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(imgUrl)),
          title: Text(title),
          trailing: SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      print(id);
                      Navigator.pushNamed(context, EditProductScreen.routeName,
                          arguments: id);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    )),
                IconButton(
                    onPressed: () async {
                      try {
                        await Provider.of<Products>(context, listen: false)
                            .deleteProduct(id);
                      } catch (err) {
                        scaffold.removeCurrentSnackBar();
                        scaffold.showSnackBar(const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text("Could not delete product")));
                      }
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ))
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}

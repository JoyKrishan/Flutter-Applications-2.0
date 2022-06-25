import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imgUrl;

  UserProductItem({required this.title, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    )),
                IconButton(
                    onPressed: () {},
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

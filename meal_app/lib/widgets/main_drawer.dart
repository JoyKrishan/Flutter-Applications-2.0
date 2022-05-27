import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildCustomListTile(
      {required IconData icon,
      required String text,
      required Function() pageSelect}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
      ),
      title: Text(
        text,
        style: TextStyle(fontSize: 25),
      ),
      onTap: pageSelect,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
            ),
            alignment: Alignment.centerLeft,
            height: 120,
            width: double.infinity,
            child: Text(
              "Cooking Up!",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 40),
            ),
          ),
          buildCustomListTile(
              icon: Icons.restaurant, text: "Meals", pageSelect: () {}),
          buildCustomListTile(
              icon: Icons.settings, text: "Filter", pageSelect: () {}),
        ],
      ),
    );
  }
}

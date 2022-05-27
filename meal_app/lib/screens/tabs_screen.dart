import 'package:flutter/material.dart';

import 'package:meal_app/screens/category_screen.dart';
import 'package:meal_app/screens/favourites_screen.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> pages = [
    {"title": "Categories", "page": const CategoriesScreen()},
    {"title": "Favourites", "page": const FavouritesScreen()}
  ];
  int _selectedPage = 0;

  void selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pages[_selectedPage]["title"]),
        ),
        drawer: const MainDrawer(),
        body: pages[_selectedPage]["page"],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: _selectedPage,
          onTap: selectPage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
              ),
              label: "Categories",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
              ),
              label: "Favourites",
            ),
          ],
        ));
  }
}

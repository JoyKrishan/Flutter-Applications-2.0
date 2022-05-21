import 'package:flutter/material.dart';
import 'package:meal_app/widgets/category_item.dart';
import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DeliMeals"),
      ),
      body: GridView(
          padding: EdgeInsets.all(25),
          children: DUMMY_CATEGORIES
              .map((cat) =>
                  CategoryItem(color: cat.color, title: cat.title, id: cat.id))
              .toList(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2, //width/height
              mainAxisSpacing: 20,
              crossAxisSpacing: 20)),
    );
  }
}

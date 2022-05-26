import 'package:flutter/material.dart';
import 'package:meal_app/screens/category_meal_screen.dart';

class CategoryItem extends StatelessWidget {
  final Color color;
  final String title;
  final String id;

  const CategoryItem({
    Key? key,
    required this.id,
    required this.color,
    required this.title,
  }) : super(key: key);

  void selectCategory(BuildContext ctx) {
    // Navigator.push(ctx, MaterialPageRoute(builder: (_) {
    //   return CategoryMealScreen(categoryTitle: title, categoryId: id);
    // }));
    Navigator.pushNamed(ctx, CategoryMealScreen.routeName,
        arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [color.withOpacity(0.7), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}

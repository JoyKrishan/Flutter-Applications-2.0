import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/widgets/meal_item.dart';
import '../models/Meals.dart';

class CategoryMealScreen extends StatelessWidget {
  // final String categoryTitle;
  // final String categoryId;
  // const CategoryMealScreen(
  //     {Key? key, required this.categoryTitle, required this.categoryId})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String categoryTitle = routeArgs['title']!;
    final String categoryId = routeArgs['id']!;
    final List<Meal> categoryMeals = DUMMY_MEALS
        .where(
          (meal) => meal.categories.contains(categoryId),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
        itemBuilder: (_, idx) => MealItem(
            title: categoryMeals[idx].title,
            imageUrl: categoryMeals[idx].imageUrl,
            complexity: categoryMeals[idx].complexity,
            affordability: categoryMeals[idx].affordability,
            duration: categoryMeals[idx].duration),
        itemCount: categoryMeals.length,
      ),
    );
  }
}

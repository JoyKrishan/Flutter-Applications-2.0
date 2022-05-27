import 'package:flutter/material.dart';

import 'package:meal_app/widgets/meal_item.dart';
import '../models/Meals.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = "/category-meal";
  final List<Meal> availableMeals;
  CategoryMealScreen(this.availableMeals);
  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  // final String categoryTitle;
  late List<Meal> displayMeals;
  late String categoryTitle;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    if (_loaded == false) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title']!;
      final String categoryId = routeArgs['id']!;
      displayMeals = widget.availableMeals
          .where(
            (meal) => meal.categories.contains(categoryId),
          )
          .toList();
      _loaded == true;
    }
    super.didChangeDependencies();
  }

  void removeItem(mealId) {
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
        itemBuilder: (_, idx) => MealItem(
            id: displayMeals[idx].id,
            title: displayMeals[idx].title,
            imageUrl: displayMeals[idx].imageUrl,
            complexity: displayMeals[idx].complexity,
            affordability: displayMeals[idx].affordability,
            duration: displayMeals[idx].duration,
            removeMeal: removeItem),
        itemCount: displayMeals.length,
      ),
    );
  }
}

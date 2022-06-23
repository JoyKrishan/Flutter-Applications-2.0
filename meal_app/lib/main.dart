import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import './screens/category_meal_screen.dart';
import './screens/category_screen.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './models/Meals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    "isGlutenfree": false,
    "isLactosefree": false,
    "isVegan": false,
    "isVegetarian": false
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _toggleFavouriteMeals(mealId) {
    setState(() {
      final existingIdx =
          _favouriteMeals.indexWhere((meal) => meal.id == mealId);
      if (existingIdx >= 0) {
        _favouriteMeals.removeAt(existingIdx);
      } else {
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    });
    print(_favouriteMeals);
  }

  bool _isFavouriteMeal(mealId) {
    return _favouriteMeals.any((meal) => meal.id == mealId);
  }

  void updateFilters(Map<String, bool> newFilters) {
    setState(() {
      filters = newFilters;
    });
    _availableMeals = DUMMY_MEALS.where((meal) {
      if (meal.isGlutenFree && newFilters["isGlutenfree"]!) {
        return true;
      }
      if (meal.isLactoseFree && newFilters["isLactosefree"]!) {
        return true;
      }
      if (meal.isVegan && newFilters["isVegan"]!) {
        return true;
      }
      if (meal.isVegetarian && newFilters["isVegetarian"]!) {
        return true;
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DeliMeals",
      theme: ThemeData(
          fontFamily: "Raleway",
          primarySwatch: Colors.teal,
          accentColor: Colors.lime,
          canvasColor: const Color.fromARGB(255, 210, 242, 246),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.normal,
                  fontSize: 20)),
          textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                  fontFamily: "RobotoCondensed",
                  fontWeight: FontWeight.bold,
                  fontSize: 20))),
      home: AnimatedSplashScreen(
          splash: Icon(
            Icons.food_bank_sharp,
            size: 100,
          ),
          splashTransition: SplashTransition.fadeTransition,
          nextScreen: TabsScreen(_favouriteMeals),
          pageTransitionType: PageTransitionType.fade),
      routes: {
        CategoryMealScreen.routeName: (ctx) =>
            CategoryMealScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavouriteMeals, _isFavouriteMeal),
        FiltersScreen.routeName: (ctx) =>
            FiltersScreen(filters, updateFilters: updateFilters),
      },
      onUnknownRoute: (setttings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}

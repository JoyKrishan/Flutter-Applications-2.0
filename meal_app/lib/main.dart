import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';

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
  List<Meal> availableMeals = DUMMY_MEALS;

  void updateFilters(Map<String, bool> newFilters) {
    setState(() {
      filters = newFilters;
    });
    availableMeals = DUMMY_MEALS.where((meal) {
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
      initialRoute: "/",
      routes: {
        "/": (ctx) => TabsScreen(),
        CategoryMealScreen.routeName: (ctx) =>
            CategoryMealScreen(availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        FiltersScreen.routeName: (ctx) =>
            FiltersScreen(filters, updateFilters: updateFilters),
      },
      onUnknownRoute: (setttings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}

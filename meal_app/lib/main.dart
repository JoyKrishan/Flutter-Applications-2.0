import 'package:flutter/material.dart';
import 'package:meal_app/screens/category_meal_screen.dart';
import 'package:meal_app/screens/category_screen.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        CategoryMealScreen.routeName: (ctx) => CategoryMealScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
      },
      onUnknownRoute: (setttings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}

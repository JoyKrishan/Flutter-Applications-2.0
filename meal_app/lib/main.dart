import 'package:flutter/material.dart';
import 'package:meal_app/category_screen.dart';

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
          accentColor: Colors.amberAccent,
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
      home: CategoriesScreen(),
    );
  }
}

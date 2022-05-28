import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/Meals.dart';

class FavouritesScreen extends StatelessWidget {
  List<Meal> favourites;

  FavouritesScreen(this.favourites, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favourites.isEmpty) {
      return const Center(
        child: Text("You do not have any favourites -- Add some!"),
      );
    } else {
      return ListView.builder(
        itemBuilder: (_, idx) => MealItem(
            id: favourites[idx].id,
            title: favourites[idx].title,
            imageUrl: favourites[idx].imageUrl,
            complexity: favourites[idx].complexity,
            affordability: favourites[idx].affordability,
            duration: favourites[idx].duration),
        itemCount: favourites.length,
      );
    }
  }
}

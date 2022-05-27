import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = "/meal-detail";

  const MealDetailScreen({Key? key}) : super(key: key);

  Widget buildTextContainers(
      {required String text, required BuildContext context}) {
    return Container(
        child: Text(
      text,
      style: Theme.of(context).textTheme.titleLarge,
    ));
  }

  Widget buildCustomContainers(
      {required MediaQueryData mediaData,
      required Widget listWidget,
      required double heightRatio}) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            border: Border.all(width: 5, color: Colors.white60),
            borderRadius: BorderRadius.circular(10)),
        height: mediaData.size.height * 0.3,
        width: 350,
        child: listWidget);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaData = MediaQuery.of(context);
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere(
      (meal) => meal.id == mealId,
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(selectedMeal.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                height: mediaData.size.height * 0.4,
                width: double.infinity,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildTextContainers(text: "Ingredients", context: context),
              buildCustomContainers(
                  mediaData: mediaData,
                  listWidget: ListView.builder(
                    itemBuilder: (ctx, idx) => Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          selectedMeal.ingredients[idx],
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      color: Theme.of(context).accentColor,
                    ),
                    itemCount: selectedMeal.ingredients.length,
                  ),
                  heightRatio: 0.3),
              buildTextContainers(text: "Steps", context: context),
              buildCustomContainers(
                  mediaData: mediaData,
                  listWidget: ListView.builder(
                    itemBuilder: (ctx, idx) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(child: Text("#${idx + 1}")),
                            title: Text(
                              selectedMeal.steps[idx],
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                    itemCount: selectedMeal.steps.length,
                  ),
                  heightRatio: 0.4),
            ],
          ),
        ));
  }
}

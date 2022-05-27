import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  Function updateFilters;
  Map<String, bool> prevFilters;

  FiltersScreen(this.prevFilters, {Key? key, required this.updateFilters})
      : super(key: key);

  static const routeName = "/filter-screen";

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegetarian = false;
  bool _isVegan = false;

  @override
  void initState() {
    print(widget.prevFilters);
    _isGlutenFree = widget.prevFilters['isGlutenfree'] as bool;
    _isLactoseFree = widget.prevFilters['isLactosefree'] as bool;
    _isVegetarian = widget.prevFilters['isVegetarian'] as bool;
    _isVegan = widget.prevFilters['isVegan'] as bool;
    super.initState();
  }

  buildSwitchTileList(String title, String subtitle, bool curValue,
      Function(bool) updateValue) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: curValue,
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Filters"),
          actions: [
            IconButton(
                onPressed: () {
                  final Map<String, bool> newFilters = {
                    "isGlutenfree": _isGlutenFree,
                    "isLactosefree": _isLactoseFree,
                    "isVegan": _isVegan,
                    "isVegetarian": _isVegetarian
                  };
                  widget.updateFilters(newFilters);
                },
                icon: const Icon(Icons.save))
          ],
        ),
        drawer: const MainDrawer(),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                "Adjust your meals",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  buildSwitchTileList(
                      "Gluten-Free",
                      "Include gluten-free meals only.",
                      _isGlutenFree, (newValue) {
                    setState(() {
                      _isGlutenFree = newValue;
                    });
                  }),
                  buildSwitchTileList(
                      "Lactose-Free",
                      "Include lactose-free meals only.",
                      _isLactoseFree, (newValue) {
                    setState(() {
                      _isLactoseFree = newValue;
                    });
                  }),
                  buildSwitchTileList(
                      "Vegan", "Include vegan meals only.", _isVegan,
                      (newValue) {
                    setState(() {
                      _isVegan = newValue;
                    });
                  }),
                  buildSwitchTileList(
                      "Vegetarian",
                      "Include vegetarian meals only.",
                      _isVegetarian, (newValue) {
                    setState(() {
                      _isVegetarian = newValue;
                    });
                  })
                ],
              ),
            )
          ],
        ));
  }
}

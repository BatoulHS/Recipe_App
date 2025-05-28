import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/home_screen.dart';

class RecipesApp extends StatefulWidget {
  const RecipesApp({super.key, required this.savedRecipesList});

  @override
  State<RecipesApp> createState() => _RecipesAppState();

  final List<Recipe> savedRecipesList;
}

class _RecipesAppState extends State<RecipesApp> {
  @override
  Widget build(BuildContext context) {
    Widget mainContent = Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          "No Recipes Saved! Start saving your magic to see them here.",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
    );
    if (widget.savedRecipesList.isNotEmpty) {
      mainContent = HomeScreen();
    }
    return Scaffold(body: Column(children: [Expanded(child: mainContent)]));
  }
}

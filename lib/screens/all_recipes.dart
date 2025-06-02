import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/widgets/recipe_card.dart';

class AllRecipes extends StatelessWidget {
  const AllRecipes({super.key, required this.recipesList});

  final List<Recipe> recipesList;

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (recipesList.isEmpty) {
      content = const Center(
        child: Text('No recipes yet!', textAlign: TextAlign.center),
      );
    } else {
      content = ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: recipesList.length,
        itemBuilder: (context, index) {
          return RecipeCard(recipe: recipesList[index]);
        },
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('All Recipes')),
      body: content,
    );
  }
}

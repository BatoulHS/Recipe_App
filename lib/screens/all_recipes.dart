import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/widgets/recipe_card.dart';

class AllRecipes extends StatelessWidget {
  const AllRecipes({super.key, required this.recipesList});

  final List<Recipe> recipesList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: ListView.builder(
          itemCount: recipesList.length,
          itemBuilder: (context, index) => RecipeCard(recipe: recipesList[index]),
        ),
      ),
    );
  }
}

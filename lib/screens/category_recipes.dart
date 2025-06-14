import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/widgets/recipe_card.dart';

class CategoryRecipes extends StatelessWidget {
  const CategoryRecipes({
    super.key,
    required this.recipes,
    required this.category,
  });

  final Category category;

  final List<Recipe> recipes;

  @override
  Widget build(BuildContext context) {
    final List<Recipe> filteredRecipes =
        recipes.where((recipe) => recipe.category == category).toList();
    String categoryName =
        category.name[0].toUpperCase() + category.name.substring(1);

    Widget content;
    
    if (filteredRecipes.isEmpty) {
      content = Center(
        child: Text(
          'No $categoryName recipes yet!',
          textAlign: TextAlign.center,
        ),
      );
    } else {
      content = ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: filteredRecipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(recipe: filteredRecipes[index]);
        },
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text('$categoryName Recipes')),
      body: content,
    );
  }
}

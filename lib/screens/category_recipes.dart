import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/widgets/recipe_card.dart';

class CategoryRecipes extends StatelessWidget{
  const CategoryRecipes({super.key, required this.recipes, required this.category});

  final Category category;

  final List<Recipe> recipes;

  @override
  Widget build(BuildContext context) {
    final List<Recipe> filteredRecipes = recipes.where((recipe) => recipe.category == category).toList();
    String categoryName = category.name[0].toUpperCase() + category.name.substring(1);
    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName Recipes'),
      ),
      body: ListView.builder(
        itemCount: filteredRecipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(recipe: filteredRecipes[index],);
        },
      )
    );
  }
}
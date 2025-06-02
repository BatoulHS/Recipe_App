import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/widgets/recipe_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key, required this.recipes});
  final List<Recipe> recipes;
  @override
  Widget build(BuildContext context) {
    final List<Recipe> favoriteRecipes = recipes.where((recipe) => recipe.isFavorite == true).toList();

    Widget content;
    if (favoriteRecipes.isEmpty) {
      content = const Center(
        child: Text(
          'No favorite recipes yet!',
          textAlign: TextAlign.center,
        ),
      );
    } else {
      content = ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(recipe: favoriteRecipes[index]);
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: content,
    );
  }
}

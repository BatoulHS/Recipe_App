import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/category_recipes.dart';
import 'package:recipe_app/screens/recipe_details.dart';
import 'package:recipe_app/widgets/category_button.dart';
import 'package:recipe_app/widgets/recipe_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.savedRecipes});

  final List<Recipe> savedRecipes;

  final List<Category> _categories = Category.values;

  List<Recipe> _getRandomRecipes(List<Recipe> allRecipes, int count) {
    if (allRecipes.isEmpty) {
      return [];
    }
    final shuffled = List.of(allRecipes)..shuffle();
    return shuffled.take(count).toList();
  }

  @override
  Widget build(BuildContext context) {
    final randomRecipes = _getRandomRecipes(savedRecipes, 6);
    Widget content;
    if (randomRecipes.isEmpty) {
      content = const Center(
        child: Column(
          children: [
            SizedBox(height: 200),
            Text(
              'No Recipes Saved! Start saving your magic to see them here.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {
      content = GridView.builder(
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        itemCount: randomRecipes.length,
        itemBuilder:
            (context, index) => RecipeGridCard(
              recipe: randomRecipes[index],
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              RecipeDetails(recipe: randomRecipes[index]),
                    ),
                  ),
            ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hello Chef,',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        // padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Text("What are you cooking today?", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return CategoryButton(
                    category: category,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (ctx) => CategoryRecipes(
                                recipes: savedRecipes,
                                category: category,
                              ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text("Check out your Recipes", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            content,
          ],
        ),
      ),
    );
  }
}

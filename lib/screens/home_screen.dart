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
    final shuffled = List.of(allRecipes)..shuffle();
    return shuffled.take(count).toList();
  }

  @override
  Widget build(BuildContext context) {
    final randomRecipes = _getRandomRecipes(savedRecipes, 6);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: ListView(
          children: [
            Text(
              "Hello Chef,",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
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
            GridView.builder(
              padding: const EdgeInsets.all(16),
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
            ),
          ],
        ),
      ),
    );
  }
}

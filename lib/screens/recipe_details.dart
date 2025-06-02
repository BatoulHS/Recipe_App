import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';

class RecipeDetails extends StatelessWidget {
  const RecipeDetails({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    List<String> ingredientsList = recipe.ingredients.split('|');

    List<String> instructionsList = recipe.instructions.split('|');

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_border_sharp),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(recipe.image),
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Recipe Details",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 10, thickness: 1),

              const SizedBox(height: 10),

              Row(
                children: [
                  // TODO AKID 8AYER ICON WLW SHO HA
                  Icon(Icons.category, size: 20, color: Colors.grey[700]),
                  const SizedBox(width: 8),
                  Text(
                    "Category: ${recipe.category.name[0].toUpperCase() + recipe.category.name.substring(1)}",
                    style: const TextStyle(fontSize: 16), // Explicit font size
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  // TODO barchartttttttttt???????????????????
                  Icon(Icons.bar_chart, size: 20, color: Colors.grey[700]),
                  const SizedBox(width: 8),
                  Text(
                    "Difficulty: ${recipe.difficulty.name[0].toUpperCase() + recipe.difficulty.name.substring(1)}",
                    style: const TextStyle(fontSize: 16), // Explicit font size
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.timer, size: 20, color: Colors.grey[700]),
                  const SizedBox(width: 8),
                  Text(
                    "Duration: ${recipe.duration.inMinutes} minutes",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const Text(
                "Ingredients",
                style: TextStyle(
                  fontSize: 20, // Explicit font size
                  fontWeight: FontWeight.bold,
                ),
              ),

              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ingredientsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    minLeadingWidth: 10,
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    leading: const Icon(Icons.circle, size: 8),
                    title: Text(
                      ingredientsList[index].toUpperCase()[0] +
                          ingredientsList[index].substring(1),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              const Text(
                "Instructions",
                style: TextStyle(
                  fontSize: 20, // Explicit font size
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                // itemExtent: 24,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: instructionsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    minLeadingWidth: 10,
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    leading: Text(
                      "${index + 1}.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text(
                      instructionsList[index].toUpperCase()[0] +
                          instructionsList[index].substring(1),
                    ),
                  );
                },
              ),
              if (recipe.notes != null && recipe.notes!.isNotEmpty) ...[
                const SizedBox(height: 24),
                const Text(
                  "Notes",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1),
                  ),
                  child: Text(
                    recipe.notes!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

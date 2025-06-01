// import 'package:flutter/material.dart';
// import 'package:recipe_app/models/recipe.dart';

// class RecipeDetails extends StatelessWidget{
//   const RecipeDetails ({super.key, required this.recipe});

//   final Recipe recipe;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Text("data"),
//     );
//   }
// }

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
      appBar: AppBar(title: Text(recipe.name)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   width: double.infinity,
              //   height: 250,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     image: DecorationImage(
              //       image: FileImage(File(recipe.image)),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              //   // child: Image.file(File(recipe.image), fit: BoxFit.cover),
              // ),
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
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Category: ${recipe.category.name[0].toUpperCase() + recipe.category.name.substring(1)}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "Difficulty: ${recipe.difficulty.name[0].toUpperCase() + recipe.difficulty.name.substring(1)}",
              ),
              Text("Duration: ${recipe.duration.inMinutes} min"),
              const SizedBox(height: 16),
              Text(
                "Ingredients",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(recipe.ingredients.replaceAll('|', '\n')),
              const SizedBox(height: 16),
              Text(
                "Instructions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(recipe.instructions.replaceAll('|', '\n')),
              if (recipe.notes != null && recipe.notes!.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  "Notes",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(recipe.notes!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

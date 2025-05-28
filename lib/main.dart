import 'package:flutter/material.dart';
import 'package:recipe_app/data/recipe_storage.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // before async in main

  List<Recipe> recipesList = await loadRecipe();

  runApp(MainApp(savedRecipes: recipesList,));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.savedRecipes,});

  final List<Recipe> savedRecipes;

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}

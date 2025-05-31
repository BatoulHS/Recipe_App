import 'package:flutter/material.dart';
import 'package:recipe_app/data/recipe_storage.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/home_screen.dart';
import 'package:recipe_app/screens/new_recipe.dart';
import 'package:material_duration_picker/material_duration_picker.dart';


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
      localizationsDelegates: const [
        DefaultDurationPickerMaterialLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: NewRecipe(),
      ),
    );
  }
}

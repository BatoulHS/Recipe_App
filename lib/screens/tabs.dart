import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/data/recipe_storage.dart';
import 'package:recipe_app/recipes_app.dart';
import 'package:recipe_app/screens/all_recipes.dart';
import 'package:recipe_app/screens/favorites_screen.dart';
import 'package:recipe_app/screens/new_recipe.dart';
import 'package:recipe_app/screens/search_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key, required this.savedRecipes});

  final List<Recipe> savedRecipes;

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;

  void _addNewRecipe(Recipe recipe) async {
    setState(() {
      widget.savedRecipes.add(recipe);
      _selectedIndex = 1;
    });
    await insertRecipe(recipe);
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = RecipesApp(savedRecipesList: widget.savedRecipes);

    if (_selectedIndex == 1) {
      activePage = AllRecipes(recipesList: widget.savedRecipes);
    }

    if (_selectedIndex == 2) {
      activePage = NewRecipe(onSave: _addNewRecipe);
    }

    if (_selectedIndex == 3) {
      activePage = SearchScreen();
    }

    if (_selectedIndex == 4) {
      activePage = FavoritesScreen();
    }

    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedIndex,
        // backgroundColor: Colors.blue, // Background color
        // selectedItemColor: Colors.white, // Selected icon/text color
        // unselectedItemColor: Colors.white70, // Unselected icon/text color
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'All Recipes',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

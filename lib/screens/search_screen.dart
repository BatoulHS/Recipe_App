import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/recipe_details.dart';
import 'package:recipe_app/widgets/recipe_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.recipesList});

  final List<Recipe> recipesList;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Recipe> _getRandomRecipes(List<Recipe> allRecipes, int count) {
    if (allRecipes.isEmpty) {
      return [];
    }
    final shuffled = List.of(allRecipes)..shuffle();
    return shuffled.take(count).toList();
  }
  Widget _buildSearchScreen() {
    if (!_hasSearched) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Search for what you crave!"),
            ElevatedButton(
              onPressed:() {
                final randomRecipes = _getRandomRecipes(widget.recipesList, 1);
                if (randomRecipes.isNotEmpty) {
                  final randomRecipe = randomRecipes.first;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => RecipeDetails(recipe: randomRecipe),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No recipes available to surprise you with!')),
                  );
                }
              },
             child: const Text("Surprise Me!")),
          ],
        ),
      );
    }

    return _searchResults.isEmpty
        ? const Center(child: Text('No recipes found'))
        : Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder:
                (context, index) => RecipeCard(recipe: _searchResults[index]),
          ),
        );
  }

  bool _hasSearched = false;

  final _searchController = TextEditingController();

  List<Recipe> _searchResults = [];
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchRecipes);
  }

  @override
  void dispose() {
    _searchController.removeListener(_searchRecipes);
    _searchController.dispose();
    super.dispose();
  }

  void _searchRecipes() {
    final query = _searchController.text.trim();
    setState(() {
      _hasSearched = _searchController.text.isNotEmpty;
      _searchResults = _search(query, widget.recipesList);
    });
  }

  List<Recipe> _search(String query, List<Recipe> recipes) {
    if (query.isEmpty) {
      return [];
    }
    return recipes.where((recipe) {
      return recipe.name.toLowerCase().contains(query.toLowerCase()) ||
          recipe.ingredients.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search by name or ingredient',
            hintStyle: TextStyle(fontSize: 14),
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _hasSearched = false;
                });
              },
            ),
          ),
          autofocus: true,
        ),
      ),
      body: _buildSearchScreen(),
    );
  }
}

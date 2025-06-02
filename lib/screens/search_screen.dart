import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/widgets/recipe_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.recipesList});

  final List<Recipe> recipesList;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Widget _buildSearchScreen() {
    if (!_hasSearched) {
      return Center(
        child: const Text(
          "Search for what you crave!",
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

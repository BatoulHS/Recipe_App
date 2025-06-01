import 'package:recipe_app/data/database.dart';
import 'package:recipe_app/models/recipe.dart';
// import 'package:sqflite/sqflite.dart';

Future<void> insertRecipe(Recipe recipe) async{
  RecipeDatabase database = RecipeDatabase();
  final db = await database.getDatabase();
  await db.insert('recipe', recipe.recipeMap);
}

Future<List<Recipe>> loadRecipe() async{
  RecipeDatabase database = RecipeDatabase();
  final db = await database.getDatabase();
  final result = await db.query('recipe');
  List<Recipe> resultList = result.map((row){
    return Recipe(
      id: row['id'] as String,
      image: row['image'] as String,
      isFavorite: row['isFavorite'] as int == 1 ? true : false,
      notes: row['notes'] as String?,
      name: row['name'] as String,
      ingredients: row['ingredients'] as String, 
      instructions: row['instructions'] as String, 
      duration: Duration(seconds: row['duration'] as int),
      category: categoryName[row['category'] as String]!,
      difficulty: difficultyName[row['difficulty'] as String]!
    );
  }).toList();
  return resultList;
}


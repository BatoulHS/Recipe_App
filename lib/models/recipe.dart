import 'package:uuid/uuid.dart';

class Recipe {
  final String id; // uuid
  final String name;
  final String ingredients;
  final String instructions;
  final Duration duration; // material_duration_picker 
  final Category category;
  final Difficulty difficulty;
  final String? notes;
  final String? image; // image path from path provider + image picker
  final bool isFavorite;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.duration,
    required this.category,
    required this.difficulty,
    this.notes,
    this.isFavorite = false,
    this.image,
    id
  }):id = id ?? Uuid().v4();

  Map<String,Object?> get recipeMap{
    return{
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'instructions': instructions,
      'duration': duration.inSeconds,
      'category': category.name,
      'difficulity': difficulty.name,
      'notes': notes,
      'isFavorite': isFavorite,
      'image': image,
    };
  }

}

enum Category { breakfast, lunch, dinner, sweets, drinks }

const categoryName = {
  'Breakfast': Category.breakfast,
  'Lunch': Category.lunch,
  'Dinner': Category.dinner,
  'Sweets': Category.sweets,
  'Drinks': Category.drinks
};

enum Difficulty { easy, medium, hard }

const difficultyName = {
  'Easy': Difficulty.easy,
  'Medium': Difficulty.medium,
  'Hard': Difficulty.hard
};



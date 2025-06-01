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
  final String image; // image path from path provider + image picker
  final bool isFavorite;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.duration,
    required this.category,
    required this.difficulty,
    required this.image,
    this.notes,
    this.isFavorite = false,
    id,
  }) : id = id ?? Uuid().v4();

  String get formatedDuration {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}';
    } else {
      return '0:${minutes.toString().padLeft(2, '0')}';
    }
  }

  Map<String, Object?> get recipeMap {
    return {
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'instructions': instructions,
      'duration': duration.inSeconds,
      'category': category.name,
      'difficulty': difficulty.name,
      'notes': notes,
      'isFavorite': isFavorite ? 1 : 0,
      'image': image,
    };
  }
//TODO REMOVE COMMENTS
  // List<String> get ingredientsList => ingredients.split('|');

  // List<String> get instructionsList => instructions.split('|');
}

enum Category { breakfast, lunch, dinner, sweets, drinks, snacks }

const categoryName = {
  'breakfast': Category.breakfast,
  'lunch': Category.lunch,
  'dinner': Category.dinner,
  'sweets': Category.sweets,
  'snacks': Category.snacks,
  'drinks': Category.drinks,
};

enum Difficulty { easy, medium, hard }

const difficultyName = {
  'easy': Difficulty.easy,
  'medium': Difficulty.medium,
  'hard': Difficulty.hard,
};

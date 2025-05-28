import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class RecipeDatabase {
  Future<Database> getDatabase() async {
    String databasePath = await getDatabasesPath();
    Database db = await openDatabase(
      join(databasePath, 'recipes.db'),
      onCreate:
          (db, version) => db.execute(
            'CREATE TABLE recipe(id TEXT PRIMARY KEY, name TEXT, ingredients TEXT, instructions TEXT, duration INTEGER, category TEXT, difficulty TEXT, notes TEXT, image TEXT, isFavorite INTEGER DEFAULT 0)',
          ),
      version: 1,
    );
    return db;
  }
}

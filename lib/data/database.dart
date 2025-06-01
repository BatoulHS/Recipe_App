import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class RecipeDatabase {
  Future<Database> getDatabase() async {
    String databasePath = await getDatabasesPath();
    Database db = await openDatabase(
      join(databasePath, 'recipes.db'),
      onCreate:
          (db, version) => db.execute(
            'CREATE TABLE recipe(id TEXT PRIMARY KEY NOT NULL, name TEXT NOT NULL, ingredients TEXT NOT NULL, instructions TEXT NOT NULL, duration INTEGER NOT NULL, category TEXT NOT NULL, difficulty TEXT NOT NULL, notes TEXT, image TEXT NOT NULL, isFavorite INTEGER DEFAULT 0)',
          ),
      version: 1,
    );
    return db;
  }
}

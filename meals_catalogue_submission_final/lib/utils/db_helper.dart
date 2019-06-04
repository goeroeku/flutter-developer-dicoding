import 'dart:async';
import 'dart:io' as io;

import 'package:meals_catalogue/models/recipe.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();
  DBHelper.internal();

  factory DBHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await setDB();
    return _db;
  }

  setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "mealsDb");
    var dB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE favorite(id INTEGER PRIMARY KEY, idMeal TEXT, strMeal TEXT, strInstructions TEXT, strMealThumb TEXT, strTags TEXT, strCategory TEXT)");
    print("DB Created");
  }

  Future<int> insert(Recipe recipe) async {
    var dbClient = await db;
    int res = await dbClient.insert("favorite", recipe.toJson());
    print("Favorite data Inserted");
    return res;
  }

  Future<Recipe> get(String idMeal) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(
        "SELECT * FROM favorite WHERE idMeal=? ORDER BY idMeal DESC", [idMeal]);

    Recipe recipe;
    if (list.length > 0) {
      recipe = Recipe(
        idMeal: list[0]["idMeal"],
        strMeal: list[0]["strMeal"],
        strInstructions: list[0]["strInstructions"],
        strMealThumb: list[0]["strMealThumb"],
        strTags: list[0]["strTags"],
        strCategory: list[0]["strCategory"],
      );
    }

    return recipe;
  }

  Future<List<Recipe>> gets(String category) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(
        "SELECT * FROM favorite WHERE strCategory=? ORDER BY idMeal DESC",
        [category]);
    List<Recipe> favorites = List();
    for (int i = 0; i < list.length; i++) {
      Recipe favorite = Recipe(
        idMeal: list[i]["idMeal"],
        strMeal: list[i]["strMeal"],
        strInstructions: list[i]["strInstructions"],
        strMealThumb: list[i]["strMealThumb"],
        strTags: list[i]["strTags"],
        strCategory: list[i]["strCategory"],
      );
      favorite.setFavoriteId(list[i]['idMeal']);
      favorites.add(favorite);
    }

    return favorites;
  }

  Future<List<Recipe>> filter(String filter) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(
        "SELECT * FROM favorite WHERE strMeal Like ? ORDER BY idMeal DESC",
        ["%$filter%"]);
    List<Recipe> favorites = List();
    for (int i = 0; i < list.length; i++) {
      Recipe favorite = Recipe(
        idMeal: list[i]["idMeal"],
        strMeal: list[i]["strMeal"],
        strInstructions: list[i]["strInstructions"],
        strMealThumb: list[i]["strMealThumb"],
        strTags: list[i]["strTags"],
        strCategory: list[i]["strCategory"],
      );
      favorite.setFavoriteId(list[i]['idMeal']);
      favorites.add(favorite);
    }

    return favorites;
  }

  Future<int> delete(Recipe recipe) async {
    var dbClient = await db;
    int res = await dbClient
        .rawDelete("DELETE FROM favorite WHERE idMeal = ?", [recipe.idMeal]);

    print("Favorite data deleted");
    return res;
  }

  Future<bool> isFavorite(Recipe recipe) async {
    var dbClient = await db;
    var res = await dbClient
        .rawQuery("SELECT * FROM favorite WHERE idMeal = ?", [recipe.idMeal]);

    return res.isNotEmpty;
  }
}

import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:meals_catalogue/adapters/meals_adapter.dart';
import 'package:meals_catalogue/adapters/recipe_adapter.dart';
import 'package:meals_catalogue/models/favorite.dart';
import 'package:meals_catalogue/models/recipe.dart';
import 'package:meals_catalogue/utils/db_helper.dart';
import 'package:meals_catalogue/utils/utils_helper.dart';

class ApiHelper {
  Client client = Client();
  int currentBottomNav = 0;
  int currentUpperNav = 0;
  bool isSearching = false;
  String searchQuery = "";

  Future<MealsAdapter> fetchData(
      {int currentBottomNav = 0,
      int currentUpperNav = 0,
      bool isSearching = false,
      String searchQuery = ""}) async {
    MealsAdapter mealsAdapter;
    String feature;

    if (currentBottomNav < 2) {
      switch (currentBottomNav) {
        case 1:
          feature = "filter.php?c=Seafood";
          break;
        default:
          feature = "filter.php?c=Dessert";
          break;
      }

      if (isSearching && searchQuery.isNotEmpty) {
        feature = "search.php?s=$searchQuery";
      }

      var res = await client.get(UtilsHelper.apiUrl + feature);
      final jsonRes = jsonDecode(res.body);

      mealsAdapter = MealsAdapter.fromJson(jsonRes);
    } else {
      var db = DBHelper();

      var category = "";
      if (currentUpperNav == 0) {
        category = "Dessert";
      } else {
        category = "Seafood";
      }

      var data;
      if (isSearching && searchQuery.isNotEmpty) {
        data = await db.filter(searchQuery);
      } else {
        data = await db.gets(category);
      }

      mealsAdapter = MealsAdapter.fromDb(data);
    }

    return mealsAdapter;
  }

  Future<Favorite> fetchDetail({String idMeal}) async {
    RecipeAdapter recipeAdapter;
    Recipe recipe;
    bool isFavorite = false;

    var res = await client.get(UtilsHelper.apiUrl + "lookup.php?i=" + idMeal);
    final jsonRes = jsonDecode(res.body);

    recipeAdapter = RecipeAdapter.fromJson(jsonRes);
    if (recipeAdapter != null && recipeAdapter.recipe != null) {
      recipe = recipeAdapter.recipe[0];
    }

    var db = DBHelper();
    if (recipe != null) {
      isFavorite = await db.isFavorite(recipe);
    }

    Favorite data = Favorite(recipe: recipe, isFavorite: isFavorite);
    return data;
  }
}

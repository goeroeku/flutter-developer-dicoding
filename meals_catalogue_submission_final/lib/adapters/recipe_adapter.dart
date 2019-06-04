import 'package:meals_catalogue/models/recipe.dart';

class RecipeAdapter {
  List<Recipe> recipe;

  RecipeAdapter({this.recipe});

  RecipeAdapter.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      recipe = List<Recipe>();
      json['meals'].forEach((v) {
        recipe.add(Recipe.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.recipe != null) {
      data['recipe'] = this.recipe.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

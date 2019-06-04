import 'package:meals_catalogue/model/recipe.dart';

class Meals {
  List<Recipe> recipe;

  Meals({this.recipe});

  Meals.fromJson(Map<String, dynamic> json) {
    if (json['recipe'] != null) {
      recipe = List<Recipe>();
      json['recipe'].forEach((v) {
        recipe.add(Recipe.fromJson(v));
      });
    }
  }

  Meals.fromJsonCategory(Map<String, dynamic> json, int category) {
    if (json['recipe'] != null) {
      recipe = List<Recipe>();
      json['recipe'].forEach((v) {
        if (v["id"] % 2 == category) recipe.add(Recipe.fromJson(v));
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

  /// Function for get recipe with filter by category
  /// category 1 is Breakfast, 2 is Desert.
  Map<String, dynamic> toJsonCategory(int category) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.recipe != null) {
      data['recipe'] = this.recipe.map((v) {
        if (v.id % 2 == category) return v.toJson();
      }).toList();
    }
    return data;
  }
}

import 'package:meals_catalogue/models/meals.dart';

class MealsAdapter {
  List<Meals> meals;

  MealsAdapter({this.meals});

  MealsAdapter.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = List<Meals>();
      json['meals'].forEach((v) {
        meals.add(Meals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.meals != null) {
      data['recipe'] = this.meals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

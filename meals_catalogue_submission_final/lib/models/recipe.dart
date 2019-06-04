class Recipe {
  String idMeal;
  String strMeal;
  String strInstructions;
  String strMealThumb;
  String strTags;
  String strCategory;

  Recipe({
    this.idMeal,
    this.strMeal,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strCategory,
  });

  Recipe.fromJson(Map<String, dynamic> json) {
    idMeal = json['idMeal'];
    strMeal = json['strMeal'];
    strInstructions = json['strInstructions'];
    strMealThumb = json['strMealThumb'];
    strTags = json['strTags'];
    strCategory = json['strCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['idMeal'] = this.idMeal;
    data['strMeal'] = this.strMeal;
    data['strInstructions'] = this.strInstructions;
    data['strMealThumb'] = this.strMealThumb;
    data['strTags'] = this.strTags;
    data['strCategory'] = this.strCategory;
    return data;
  }

  void setFavoriteId(String id) {
    this.idMeal = id;
  }
}

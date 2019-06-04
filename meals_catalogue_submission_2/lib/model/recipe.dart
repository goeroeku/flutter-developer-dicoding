class Recipe {
  int id;
  String name;
  String description;
  String image;
  List<String> ingredients;

  Recipe({this.id, this.name, this.description, this.image, this.ingredients});

  Recipe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    ingredients = json['ingredients'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['ingredients'] = this.ingredients;
    return data;
  }
}

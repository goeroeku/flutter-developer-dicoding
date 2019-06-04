class Meals {
  List<Reseps> reseps;

  Meals({this.reseps});

  Meals.fromJson(Map<String, dynamic> json) {
    if (json['reseps'] != null) {
      reseps = List<Reseps>();
      json['reseps'].forEach((v) {
        reseps.add(Reseps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.reseps != null) {
      data['reseps'] = this.reseps.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reseps {
  int id;
  String name;
  String description;
  String image;
  List<String> ingredients;

  Reseps({this.id, this.name, this.description, this.image, this.ingredients});

  Reseps.fromJson(Map<String, dynamic> json) {
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
